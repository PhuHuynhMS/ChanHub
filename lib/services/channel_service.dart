import './index.dart';

import '../models/index.dart';

class ChannelService {
  Future<List<Channel>> fetchAllChannels(String workspaceId) async {
    final List<Channel> channels = [];
    try {
      final pb = await PocketBaseService.getInstance();
      final channelModels = await pb.collection('channels').getFullList(
            filter: 'workspace.id="$workspaceId" && deleted = null',
            expand: 'creator',
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
