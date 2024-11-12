import 'dart:io';

import 'package:pocketbase/pocketbase.dart';

import '../common/enums.dart';
import '../services/thread_service.dart';
import '../models/index.dart';

class ThreadsManager {
  final ThreadService _threadService = ThreadService();

  List<Thread> _threads = [];
  bool _hasMoreThreads = true;
  bool _isFetching = false;
  late Function _notifyChannelListeners;
  late String _channelId;

  ThreadsManager(String channelId, Function notifyChannelListeners) {
    _channelId = channelId;
    _notifyChannelListeners = notifyChannelListeners;
  }

  bool get isFetching => _isFetching;
  bool get hasMoreThreads => _hasMoreThreads;

  void init() async {
    _isFetching = true;
    final (threads, hasMoreThreads) =
        await _threadService.fetchThreads(_channelId);

    _threads = threads;
    _hasMoreThreads = hasMoreThreads;

    await _threadService.subscribeToChannel(
      _channelId,
      _onReceiveThread,
      _onReceiveTask,
      _onReceiveReaction,
      _onReceiveComment,
    );
    _isFetching = false;
    _notifyChannelListeners();
  }

  Future<bool> fetchMoreThreads() async {
    int currentPage = (_threads.length / 10).ceil() + 1;
    final (threads, hasMoreThreads) =
        await _threadService.fetchThreads(_channelId, page: currentPage);

    _hasMoreThreads = hasMoreThreads;

    for (final fetchThread in threads) {
      if (_threads.indexWhere((thread) => thread.id == fetchThread.id) == -1) {
        _threads.add(fetchThread);
      }
    }
    _notifyChannelListeners();
    return true;
  }

  Future<(List<Thread>, bool)> searchThreads(
    String query, {
    SearchThreadFilter filter = SearchThreadFilter.all,
    int page = 1,
    int perPage = 10,
  }) async {
    return await _threadService.searchThreads(
      _channelId,
      query,
      filter: filter,
      page: page,
      perPage: perPage,
    );
  }

  List<Thread> getAll() {
    return [..._threads];
  }

  Future<void> createThread(
    String? content,
    List<File> mediaFiles,
    List<Task> tasks,
  ) async {
    await _threadService.createThread(
      _channelId,
      Thread(
        content: content,
        mediaFiles: [...mediaFiles],
        tasks: [...tasks],
      ),
    );
  }

  Future<void> createThreadEvent(String content) async {
    await _threadService.createThreadEvent(_channelId, content);
  }

  Future<void> updateThread(Thread updatedThread) async {
    await _threadService.updateThread(updatedThread);
  }

  Future<void> deleteThread(Thread deletedThread) async {
    final isDeleted = await _threadService.deleteThread(deletedThread);

    if (isDeleted) {
      _threads.removeWhere((thread) => thread.id == deletedThread.id);
      _notifyChannelListeners();
    }
  }

  Future<bool> changeTaskStatus(Task task) async {
    return await _threadService.changeTaskStatus(task);
  }

  Future<bool> reactToThread(Thread thread, Reaction reaction) async {
    if (reaction.id != null) {
      return await _threadService.deleteReaction(reaction);
    } else {
      return await _threadService.addReaction(thread.id!, reaction);
    }
  }

  Future<bool> addCommentToThread(
      Thread thread, String content, List<File> mediaFiles) async {
    final comment = Comment(
      content: content,
      mediaFiles: mediaFiles,
    );
    return await _threadService.addComment(thread.id!, comment);
  }

  Future<bool> updateComment(Comment comment) async {
    return await _threadService.updateComment(comment);
  }

  Future<bool> deleteComment(Comment comment) async {
    return await _threadService.deleteComment(comment);
  }

  Thread? getById(String threadId) {
    int index = _threads.indexWhere((thread) => thread.id == threadId);
    if (index != -1) {
      return _threads[index];
    }
    return null;
  }

  // Realtime updates
  void _onReceiveThread(RecordSubscriptionEvent event) {
    if (event.action == 'create') {
      final thread = Thread.fromJson(event.record!.toJson());
      _threads.insert(0, thread);
    } else if (event.action == 'update') {
      final updatedThread = Thread.fromJson(event.record!.toJson());
      final index =
          _threads.indexWhere((thread) => thread.id == updatedThread.id);
      if (index != -1) {
        _threads[index] = updatedThread;
      }
    } else if (event.action == 'delete') {
      final deletedThread = Thread.fromJson(event.record!.toJson());
      _threads.removeWhere((thread) => thread.id == deletedThread.id);
    }
    _notifyChannelListeners();
  }

  void _onReceiveTask(RecordSubscriptionEvent event) {
    if (event.action == 'create' || event.action == 'update') {
      final updatedTask = Task.fromJson(event.record!.toJson());
      final threadId = event.record!.toJson()['thread'];
      final threadIndex =
          _threads.indexWhere((thread) => thread.id == threadId);
      if (threadIndex != -1) {
        final taskIndex = _threads[threadIndex]
            .tasks
            .indexWhere((task) => task.id == updatedTask.id);
        if (taskIndex != -1) {
          _threads[threadIndex].tasks[taskIndex] = updatedTask;
        } else {
          _threads[threadIndex].tasks.add(updatedTask);
        }
      }
    } else if (event.action == 'delete') {
      final deletedTask = Task.fromJson(event.record!.toJson());
      final threadId = event.record!.toJson()['thread'];
      final threadIndex =
          _threads.indexWhere((thread) => thread.id == threadId);
      if (threadIndex != -1) {
        _threads[threadIndex]
            .tasks
            .removeWhere((task) => task.id == deletedTask.id);
      }
    }
    _notifyChannelListeners();
  }

  void _onReceiveReaction(RecordSubscriptionEvent event) {
    if (event.action == 'create') {
      final reaction = Reaction.fromJson(event.record!.toJson());
      final threadId = event.record!.toJson()['thread'];
      final threadIndex =
          _threads.indexWhere((thread) => thread.id == threadId);
      if (threadIndex != -1) {
        _threads[threadIndex].reactions.add(reaction);
      }
    } else if (event.action == 'delete') {
      final deletedReaction = Reaction.fromJson(event.record!.toJson());
      final threadId = event.record!.toJson()['thread'];
      final threadIndex =
          _threads.indexWhere((thread) => thread.id == threadId);
      if (threadIndex != -1) {
        _threads[threadIndex]
            .reactions
            .removeWhere((reaction) => reaction.id == deletedReaction.id);
      }
    }
    _notifyChannelListeners();
  }

  void _onReceiveComment(RecordSubscriptionEvent event) {
    if (event.action == 'create') {
      final comment = Comment.fromJson(event.record!.toJson());
      final threadId = event.record!.toJson()['thread'];
      final threadIndex =
          _threads.indexWhere((thread) => thread.id == threadId);
      if (threadIndex != -1) {
        _threads[threadIndex].comments.add(comment);
      }
    } else if (event.action == 'update') {
      final updatedComment = Comment.fromJson(event.record!.toJson());
      final threadId = event.record!.toJson()['thread'];
      final threadIndex =
          _threads.indexWhere((thread) => thread.id == threadId);
      if (threadIndex != -1) {
        final commentIndex = _threads[threadIndex]
            .comments
            .indexWhere((comment) => comment.id == updatedComment.id);
        if (commentIndex != -1) {
          _threads[threadIndex].comments[commentIndex] = updatedComment;
        }
      }
    } else if (event.action == 'delete') {
      final deletedComment = Comment.fromJson(event.record!.toJson());
      final threadId = event.record!.toJson()['thread'];
      final threadIndex =
          _threads.indexWhere((thread) => thread.id == threadId);
      if (threadIndex != -1) {
        _threads[threadIndex]
            .comments
            .removeWhere((comment) => comment.id == deletedComment.id);
      }
    }
    _notifyChannelListeners();
  }
}
