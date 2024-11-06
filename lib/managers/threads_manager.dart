import 'dart:io';

import 'package:pocketbase/pocketbase.dart';

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
    _threads = await _threadService.fetchThreads(_channelId);
    if (_threads.isEmpty || _threads.length % 10 != 0) {
      _hasMoreThreads = false;
    }
    await _threadService.subscribeToChannel(
      _channelId,
      _onReceiveThread,
      _onReceiveTask,
      _onReceiveReaction,
    );
    _isFetching = false;
    _notifyChannelListeners();
  }

  Future<bool> fetchMoreThreads() async {
    int currentPage = (_threads.length / 10).ceil() + 1;
    final threads =
        await _threadService.fetchThreads(_channelId, page: currentPage);

    if (threads.isEmpty) {
      _hasMoreThreads = false;
      _notifyChannelListeners();
      return false;
    }

    for (final fetchThread in threads) {
      if (_threads.indexWhere((thread) => thread.id == fetchThread.id) == -1) {
        _threads.add(fetchThread);
      }
    }

    _hasMoreThreads = true;
    _notifyChannelListeners();
    return true;
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

  Future<void> updateThread(Thread updatedThread) async {
    final isUpdated = await _threadService.updateThread(updatedThread);

    if (isUpdated) {
      final index =
          _threads.indexWhere((thread) => thread.id == updatedThread.id);
      if (index != -1) {
        _threads[index] = updatedThread;
        _notifyChannelListeners();
      }
    }
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
}
