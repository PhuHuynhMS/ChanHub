import './index.dart';

import '../models/index.dart';

class ChannelService {
  Future<List<Channel>> fetchAllChannels(String workspaceId) async {
    final List<Channel> channels = [];
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model!.id;
      final channelModels = await pb.collection('channels').getFullList(
        filter: """
              workspace.id='$workspaceId' && 
              deleted = null && 
              (privacy = 'public' ||
              (privacy = 'private' && channel_members_via_channel.member.id ?= '$userId'))
            """,
        expand: 'creator,channel_members_via_channel.member',
      );
      for (final channelModel in channelModels) {
        channels.add(Channel.fromJson(channelModel.toJson()));
      }
      return channels;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }
}
