import '../../models/workspace.dart';
import '../../models/channel.dart';
import '../../models/user.dart';
import '../../common/enums.dart';

class WorkspacesManager {
  List<Workspace> workspaces = [
    Workspace(
        name: 'ChanHub Developer',
        createdBy: User(
          id: '1',
          fullName: 'John Doe',
          userName: 'johndoe',
          avatarUrl: 'https://picsum.photos/400/300',
          email: 'john@gmail.com',
        ),
        createdAt: DateTime.now(),
        id: '1',
        imageUrl: 'https://picsum.photos/400/300',
        channels: <Channel>[
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
              fullName: 'John Doe',
              userName: 'johndoe',
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
              fullName: 'John Doe',
              userName: 'johndoe',
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
              fullName: 'John Doe',
              userName: 'johndoe',
              avatarUrl: 'https://picsum.photos/300/300',
              email: 'john@gmail.com',
            ),
          ),
        ]),
    Workspace(
        name: 'Pineapple and Banana',
        createdBy: User(
          id: '1',
          fullName: 'John Doe',
          userName: 'johndoe',
          avatarUrl: 'https://picsum.photos/500/300',
          email: 'john@gmail.com',
        ),
        createdAt: DateTime.now(),
        id: '2',
        imageUrl: 'https://picsum.photos/300/300',
        channels: []),
    Workspace(
        name: 'ABCXYZ',
        createdBy: User(
          id: '1',
          fullName: 'John Doe',
          userName: 'johndoe',
          avatarUrl: 'https://picsum.photos/200/300',
          email: 'john@gmail.com',
        ),
        createdAt: DateTime.now(),
        id: '3',
        imageUrl: 'https://picsum.photos/200/300',
        channels: []),
  ];

  Workspace? getDefaultWorkspace() {
    return workspaces[0];
  }

  List<Workspace> getAll() {
    return [...workspaces];
  }

  void add(Workspace workspace) {
    workspaces.add(workspace);
  }

  void update(Workspace workspace) {
    final index = workspaces.indexWhere((w) => w.id == workspace.id);
    if (index != -1) {
      workspaces[index] = workspace;
    }
  }

  void delete(Workspace workspace) {
    workspaces.remove(workspace);
  }

  Workspace? getById(String id) {
    try {
      return workspaces.firstWhere((w) => w.id == id);
    } catch (e) {
      return null;
    }
  }
}
