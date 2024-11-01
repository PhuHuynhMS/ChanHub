import 'package:flutter/foundation.dart';

import '../models/index.dart';
import '../services/index.dart';

class ChannelsManager with ChangeNotifier {
  final ChannelService _channelService = ChannelService();

  List<Channel> _channels = [];

  Future<void> fetchChannels(String selectedWorkspaceId) async {
    _channels = await _channelService.fetchAllChannels(selectedWorkspaceId);
    notifyListeners();
  }

  List<Channel> getAll() {
    return [..._channels];
  }

  int count() {
    return _channels.length;
  }

  void add(Channel channel) {
    _channels.add(channel);
  }

  Channel? getById(String channelId) {
    try {
      return _channels.firstWhere((c) => c.id == channelId);
    } catch (error) {
      return null;
    }
  }
}
