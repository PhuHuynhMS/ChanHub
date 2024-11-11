import 'dart:io';

import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

import '../common/enums.dart';
import '../models/index.dart';
import './index.dart';

class ThreadService {
  Future<(List<Thread>, bool)> fetchThreads(
    String channelId, {
    int page = 1,
    int perPage = 10,
  }) async {
    final List<Thread> threads = [];
    try {
      final pb = await PocketBaseService.getInstance();
      final threadModels = await pb.collection('threads').getList(
        filter: """
          channel.id='$channelId'
        """,
        expand: 'creator,'
            'thread_tasks_via_thread,'
            'thread_tasks_via_thread.assignee,'
            'thread_tasks_via_thread.completed_by,'
            'thread_reactions_via_thread,'
            'thread_reactions_via_thread.creator,'
            'comments_via_thread,'
            'comments_via_thread.creator',
        page: page,
        perPage: perPage,
        sort: '-created',
      );

      for (final threadModel in threadModels.items) {
        threads.add(Thread.fromJson(threadModel.toJson()));
      }

      bool hasMoreThreads = threadModels.totalPages > page;

      return (threads, hasMoreThreads);
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<(List<Thread>, bool)> searchThreads(
    String channelId,
    String query, {
    SearchThreadFilter filter = SearchThreadFilter.all,
    int page = 1,
    int perPage = 10,
  }) async {
    final List<Thread> threads = [];
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model!.id;
      final threadModels = await pb.collection('threads').getList(
            filter: "channel.id='$channelId' && content ~ '%$query%'"
                "${filter == SearchThreadFilter.myThreads ? " && creator='$userId'" : ''}",
            expand: 'creator,'
                'thread_tasks_via_thread,'
                'thread_tasks_via_thread.assignee,'
                'thread_tasks_via_thread.completed_by,'
                'thread_reactions_via_thread,'
                'thread_reactions_via_thread.creator,'
                'comments_via_thread,'
                'comments_via_thread.creator',
            sort: '-created',
            page: page,
            perPage: perPage,
          );
      for (final threadModel in threadModels.items) {
        threads.add(Thread.fromJson(threadModel.toJson()));
      }

      bool hasMoreThreads = threadModels.totalPages > page;

      return (threads, hasMoreThreads);
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<void> subscribeToChannel(
    String channelId,
    Function(RecordSubscriptionEvent) threadCallback,
    Function(RecordSubscriptionEvent) taskCallback,
    Function(RecordSubscriptionEvent) reactionCallback,
    Function(RecordSubscriptionEvent) commentCallback,
  ) async {
    try {
      final pb = await PocketBaseService.getInstance();
      pb.collection('threads').subscribe(
            '*',
            threadCallback,
            filter: """
                      channel.id='$channelId'
                    """,
            expand:
                'creator,thread_tasks_via_thread,thread_tasks_via_thread.assignee',
          );
      pb.collection('thread_tasks').subscribe(
            '*',
            taskCallback,
            filter: """
                      thread.channel.id='$channelId'
                    """,
            expand: 'assignee,completed_by',
          );
      pb.collection('thread_reactions').subscribe(
            '*',
            reactionCallback,
            filter: """
                      thread.channel.id='$channelId'
                    """,
            expand: 'creator',
          );
      pb.collection('comments').subscribe(
            '*',
            commentCallback,
            filter: """
                      thread.channel.id='$channelId'
                    """,
            expand: 'creator',
          );
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<bool> createThread(String channelId, Thread thread) async {
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model!.id;

      final createdThread = await pb.collection('threads').create(
            body: thread.toJson()
              ..['creator'] = userId
              ..['channel'] = channelId,
            files: await _createMultipartFiles(thread.mediaFiles),
          );

      for (final task in thread.tasks) {
        await pb.collection('thread_tasks').create(
              body: task.toJson()..['thread'] = createdThread.id,
            );
      }
      return true;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<bool> updateThread(Thread thread) async {
    try {
      final pb = await PocketBaseService.getInstance();

      await pb.collection('threads').update(
            thread.id!,
            body: thread.toJson(),
          );

      return true;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<bool> deleteThread(Thread thread) async {
    try {
      final pb = await PocketBaseService.getInstance();

      await pb.collection('threads').delete(thread.id!);

      return true;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<bool> changeTaskStatus(Task task) async {
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model!.id;

      // Check if the user is the assignee of the task
      if (task.assignee != null && task.assignee!.id != userId) {
        return false;
      }
      if (task.isCompleted) {
        await pb.collection('thread_tasks').update(
              task.id!,
              body: task.toJson()
                ..['is_completed'] = false
                ..['completed'] = null
                ..['completed_by'] = null,
            );
      } else {
        await pb.collection('thread_tasks').update(
              task.id!,
              body: task.toJson()
                ..['is_completed'] = true
                ..['completed'] = DateTime.now().toUtc().toIso8601String()
                ..['completed_by'] = userId,
            );
      }
      return true;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<bool> addReaction(String threadId, Reaction reaction) async {
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model!.id;

      await pb.collection('thread_reactions').create(
            body: reaction.toJson()
              ..['creator'] = userId
              ..['thread'] = threadId,
          );
      return true;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<bool> deleteReaction(Reaction reaction) async {
    try {
      final pb = await PocketBaseService.getInstance();
      await pb.collection('thread_reactions').delete(reaction.id!);
      return true;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<bool> addComment(String threadId, Comment comment) async {
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model!.id;

      await pb.collection('comments').create(
            body: comment.toJson()
              ..['creator'] = userId
              ..['thread'] = threadId,
            files: await _createMultipartFiles(comment.mediaFiles),
          );
      return true;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<bool> updateComment(Comment comment) async {
    try {
      final pb = await PocketBaseService.getInstance();

      await pb.collection('comments').update(
            comment.id!,
            body: comment.toJson(),
          );
      return true;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<bool> deleteComment(Comment comment) async {
    try {
      final pb = await PocketBaseService.getInstance();

      await pb.collection('comments').delete(comment.id!);
      return true;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<List<http.MultipartFile>> _createMultipartFiles(
      List<File> files) async {
    return await Future.wait(
      files.map((file) async {
        return http.MultipartFile.fromBytes(
          'images',
          await file.readAsBytes(),
          filename: file.uri.pathSegments.last,
        );
      }),
    );
  }
}
