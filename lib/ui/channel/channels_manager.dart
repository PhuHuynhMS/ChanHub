import '../../models/channel.dart';
import '../../common/enums.dart';
import '../../models/user.dart';

class ChannelsManager {
  final List<Channel> _channels = <Channel>[
    Channel(
      id: 'saer2q3saw22q',
      name: 'Flutter',
      description:
          'Flutter is Google’s UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.',
      privacy: ChannelPrivacy.public,
      creatorId: '1',
      createdAt: DateTime.now(),
      memberCount: 3,
      creator: User(
        id: '1',
        fullName: 'John Doe',
        userName: 'johndoe',
        avatarUrl: 'https://picsum.photos/300/300',
        email: 'john@gmail.com',
      ),
    ),
    Channel(
      id: 'saer2q3saw221',
      name: 'Dart',
      description:
          'Dart is a client-optimized language for fast apps on any platform.',
      privacy: ChannelPrivacy.public,
      creatorId: '1',
      createdAt: DateTime.now(),
      memberCount: 10,
      creator: User(
        id: '1',
        fullName: 'John Doe',
        userName: 'johndoe',
        avatarUrl: 'https://picsum.photos/300/300',
        email: 'john@gmail.com',
      ),
    ),
    Channel(
      id: 'saer2q3saw222',
      name: 'Firebase',
      description:
          'Firebase is Google’s mobile platform that helps you quickly develop high-quality apps and grow your business.',
      privacy: ChannelPrivacy.private,
      creatorId: '1',
      createdAt: DateTime.now(),
      memberCount: 5,
      creator: User(
        id: '1',
        fullName: 'John Doe',
        userName: 'johndoe',
        avatarUrl: 'https://picsum.photos/300/300',
        email: 'john@gmail.com',
      ),
    ),
  ];

  List<Channel> get channels => _channels;

  void add(Channel channel) {
    _channels.add(channel);
  }

  void update(Channel channel) {
    final index = _channels.indexWhere((c) => c.id == channel.id);
    if (index != -1) {
      _channels[index] = channel;
    }
  }

  void delete(String channelId) {
    _channels.removeWhere((c) => c.id == channelId);
  }

  Channel? getById(String channelId) {
    return _channels.firstWhere((c) => c.id == channelId,
        orElse: () => Channel(
              id: '',
              name: '',
              description: '',
              privacy: ChannelPrivacy.public,
              creatorId: '',
              createdAt: DateTime.now(),
              creator: User(
                id: '',
                fullName: '',
                userName: '',
                avatarUrl: '',
                email: '',
              ),
            ));
  }

  List<Channel> getAll() {
    return _channels;
  }

  int count() {
    return _channels.length;
  }
}
