import 'package:pocketbase/pocketbase.dart';

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
        expand:
            'creator,channel_members_via_channel.member,channel_member_status_via_channel',
      );
      for (final channelModel in channelModels) {
        channels.add(
          Channel.fromJson(channelModel.toJson()..addAll({'userId': userId})),
        );
      }
      return channels;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<DateTime> markAllThreadsAsRead(
      String channelId, DateTime lastReadAt) async {
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model!.id;
      final channelMemberStatusModels = await pb
          .collection('channel_member_status')
          .getList(filter: "channel = '$channelId' && member = '$userId'");

      RecordModel channelMemberStatusModel;
      if (channelMemberStatusModels.totalItems == 0) {
        channelMemberStatusModel =
            await pb.collection('channel_member_status').create(body: {
          'channel': channelId,
          'member': userId,
          'last_read': lastReadAt.toIso8601String(),
        });
      } else {
        channelMemberStatusModel =
            await pb.collection('channel_member_status').update(
          channelMemberStatusModels.items[0].id,
          body: {
            'last_read': lastReadAt.toIso8601String(),
          },
        );
      }
      return DateTime.parse(channelMemberStatusModel.data['last_read']);
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }
}
