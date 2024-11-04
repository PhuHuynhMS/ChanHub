import 'dart:io';

import 'package:pocketbase/pocketbase.dart';
import 'package:http/http.dart' as http;

import '../models/index.dart';
import './index.dart';

class ThreadService {
  Future<List<Thread>> fetchThreads(
    String channelId, {
    int page = 1,
    int perPage = 10,
  }) async {
    final List<Thread> threads = [];
    try {
      final pb = await PocketBaseService.getInstance();
      final threadModels = await pb.collection('threads').getList(
        filter: """
          channel.id='$channelId' && 
          deleted=null
        """,
        expand:
            'creator,thread_tasks_via_thread,thread_tasks_via_thread.assignee,thread_tasks_via_thread.completed_by,thread_reactions_via_thread,thread_reactions_via_thread.creator',
        page: page,
        perPage: perPage,
        sort: '-created',
      );

      for (final threadModel in threadModels.items) {
        threads.add(Thread.fromJson(threadModel.toJson()));
      }

      return threads;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<void> subscribeToChannel(
    String channelId,
    Function(RecordSubscriptionEvent) threadCallback,
    Function(RecordSubscriptionEvent) taskCallback,
    Function(RecordSubscriptionEvent) reactionCallback,
  ) async {
    try {
      final pb = await PocketBaseService.getInstance();
      pb.collection('threads').subscribe(
            '*',
            threadCallback,
            filter: """
                      channel.id='$channelId' && 
                      deleted=null
                    """,
            expand:
                'creator,thread_tasks_via_thread,thread_tasks_via_thread.assignee',
          );
      pb.collection('thread_tasks').subscribe(
            '*',
            taskCallback,
            filter: """
                      thread.channel.id='$channelId' && 
                      deleted=null
                    """,
            expand: 'assignee,completed_by',
          );
      pb.collection('thread_reactions').subscribe(
            '*',
            reactionCallback,
            filter: """
                      thread.channel.id='$channelId' && 
                      deleted=null
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
