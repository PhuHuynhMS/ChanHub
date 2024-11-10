import 'package:flutter/foundation.dart';

import '../models/index.dart';
import '../services/index.dart';
import './index.dart';

class ChannelsManager with ChangeNotifier {
  final ChannelService _channelService = ChannelService();

  List<Channel> _channels = [];
  String? _selectedChannelId;
  bool _isFetching = false;
  Map<String, ThreadsManager> threadsManagers = {};

  bool get isFetching => _isFetching;

  Future<void> fetchChannels(String? selectedWorkspaceId) async {
    if (selectedWorkspaceId == null) {
      return;
    }
    _isFetching = true;
    notifyListeners();

    _channels = await _channelService.fetchAllChannels(selectedWorkspaceId);
    _initThreadsManagers();

    _isFetching = false;
    notifyListeners();
  }

  List<Channel> getAll() {
    return [..._channels];
  }

  Channel? getSelectedChannel() {
    if (_selectedChannelId == null) {
      return null;
    }
    return getById(_selectedChannelId!);
  }

  void setSelectedChannel(Channel channel) {
    _selectedChannelId = channel.id;
    notifyListeners();
  }

  ThreadsManager getCurrentThreadsManager() {
    return threadsManagers[_selectedChannelId!]!;
  }

  bool hasNewThreads(String channelId, User loggedInUser) {
    final channel = getById(channelId);
    if (channel?.lastReadAt == null) {
      return threadsManagers[channelId]!.getAll().isNotEmpty;
    }
    return threadsManagers[channelId]!.getAll().any(
          (thread) =>
              thread.createdAt!.isAfter(channel!.lastReadAt!) &&
              thread.creator?.id != loggedInUser.id,
        );
  }

  Future<bool> markAllThreadsAsRead(String channelId) async {
    final channel = getById(channelId);
    if (channel == null) {
      return false;
    }
    final lastReadAt = DateTime.now().toUtc();
    _channels = _channels.map((channel) {
      return channel.id == channelId
          ? channel.copyWith(lastReadAt: lastReadAt)
          : channel;
    }).toList();

    await _channelService.markAllThreadsAsRead(channelId, lastReadAt);

    return true;
  }

  Channel? getById(String channelId) {
    try {
      return _channels.firstWhere((channel) => channel.id == channelId);
    } catch (error) {
      return null;
    }
  }

  void _initThreadsManagers() {
    for (Channel channel in _channels) {
      threadsManagers[channel.id!] =
          ThreadsManager(channel.id!, notifyListeners)..init();
    }
  }
}
