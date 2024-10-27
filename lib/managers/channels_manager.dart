import 'package:flutter/foundation.dart';

import '../common/enums.dart';
import '../models/index.dart';

class ChannelsManager with ChangeNotifier {
  final List<Channel> _channels = <Channel>[
    Channel(
      id: '1',
      name: 'Flutter',
      description:
          'Flutter is Google’s UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.',
      privacy: ChannelPrivacy.public,
      creatorId: '1',
      createdAt: DateTime.now(),
      memberCount: 3,
      creator: User(
        id: '1',
        fullname: 'John Doe',
        jobTitle: "Software Developer",
        username: 'johndoe',
        avatarUrl: 'https://picsum.photos/300/300',
        email: 'john@gmail.com',
      ),
    ),
    Channel(
      id: '2',
      name: 'Dart',
      description:
          'Dart is a client-optimized language for fast apps on any platform.',
      privacy: ChannelPrivacy.public,
      creatorId: '1',
      createdAt: DateTime.parse('2021-09-01'),
      memberCount: 10,
      creator: User(
        id: '1',
        fullname: 'John Doe',
        jobTitle: "Software Developer",
        username: 'johndoe',
        avatarUrl: 'https://picsum.photos/300/300',
        email: 'john@gmail.com',
      ),
    ),
    Channel(
      id: '3',
      name: 'Firebase',
      description:
          'Firebase is Google’s mobile platform that helps you quickly develop high-quality apps and grow your business.',
      privacy: ChannelPrivacy.private,
      creatorId: '1',
      createdAt: DateTime.now(),
      memberCount: 5,
      creator: User(
        id: '1',
        fullname: 'John Doe',
        jobTitle: "Software Developer",
        username: 'johndoe',
        avatarUrl: 'https://picsum.photos/300/300',
        email: 'john@gmail.com',
      ),
    ),
  ];

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
