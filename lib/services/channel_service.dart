import 'package:pocketbase/pocketbase.dart';

import '../common/enums.dart';
import '../models/index.dart';
import './index.dart';

class ChannelService {
  Future<List<Channel>> fetchAllChannels(String workspaceId) async {
    final List<Channel> channels = [];
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model!.id;
      final channelModels = await pb.collection('channels').getFullList(
        filter: """
              workspace.id='$workspaceId' && 
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

  Future<bool> createChannel(String workspaceId, Channel channel) async {
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model!.id;
      final channelModel = await pb.collection('channels').create(
            body: channel.toJson()
              ..['creator'] = userId
              ..['workspace'] = workspaceId,
          );

      if (channel.privacy == ChannelPrivacy.private) {
        await pb.collection('channel_members').create(
          body: {
            'channel': channelModel.id,
            'member': userId,
          },
        );
      }
      return true;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<bool> updateChannel(Channel channel) async {
    try {
      final pb = await PocketBaseService.getInstance();
      await pb.collection('channels').update(
            channel.id!,
            body: channel.toJson(),
          );

      return true;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<bool> deleteChannel(Channel channel) async {
    try {
      final pb = await PocketBaseService.getInstance();
      await pb.collection('channels').delete(channel.id!);

      return true;
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
