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
      ],
      members: [
        User(
          id: '1',
          fullName: 'John Smith',
          userName: 'john_smith',
          email: 'johnsmith@gmail.com',
          avatarUrl: 'https://picsum.photos/400/300',
        ),
        User(
          id: '2',
          fullName: 'Emily Brown',
          userName: 'emily_brown',
          email: 'emily@gmail.com',
          avatarUrl: 'https://picsum.photos/350/300',
        ),
        User(
          id: '3',
          fullName: 'Michael Johnson',
          userName: 'michael_j',
          email: 'michael@gmail.com',
          avatarUrl: 'https://picsum.photos/420/320',
        ),
        User(
          id: '4',
          fullName: 'Sophia White',
          userName: 'sophia_w',
          email: 'sophia@gmail.com',
          avatarUrl: 'https://picsum.photos/400/400',
        ),
        User(
          id: '5',
          fullName: 'David Wilson',
          userName: 'david_w',
          email: 'david@gmail.com',
          avatarUrl: 'https://picsum.photos/450/300',
        ),
        User(
          id: '6',
          fullName: 'Olivia Lee',
          userName: 'olivia_lee',
          email: 'olivia@gmail.com',
          avatarUrl: 'https://picsum.photos/380/330',
        ),
        User(
          id: '7',
          fullName: 'Chris Martin',
          userName: 'chris_m',
          email: 'chris@gmail.com',
          avatarUrl: 'https://picsum.photos/400/350',
        ),
        User(
          id: '8',
          fullName: 'Isabella Harris',
          userName: 'isabella_h',
          email: 'isabella@gmail.com',
          avatarUrl: 'https://picsum.photos/370/340',
        ),
        User(
          id: '9',
          fullName: 'James Clark',
          userName: 'james_c',
          email: 'james@gmail.com',
          avatarUrl: 'https://picsum.photos/430/300',
        ),
        User(
          id: '10',
          fullName: 'Mia Anderson',
          userName: 'mia_a',
          email: 'mia@gmail.com',
          avatarUrl: 'https://picsum.photos/400/310',
        ),
        User(
          id: '11',
          fullName: 'Ethan Walker',
          userName: 'ethan_w',
          email: 'ethan@gmail.com',
          avatarUrl: 'https://picsum.photos/420/380',
        ),
        User(
          id: '12',
          fullName: 'Ava Taylor',
          userName: 'ava_t',
          email: 'ava@gmail.com',
          avatarUrl: 'https://picsum.photos/360/390',
        ),
        User(
          id: '13',
          fullName: 'Liam Thompson',
          userName: 'liam_t',
          email: 'liam@gmail.com',
          avatarUrl: 'https://picsum.photos/410/310',
        ),
        User(
          id: '14',
          fullName: 'Charlotte Miller',
          userName: 'charlotte_m',
          email: 'charlotte@gmail.com',
          avatarUrl: 'https://picsum.photos/380/360',
        ),
        User(
          id: '15',
          fullName: 'Lucas Moore',
          userName: 'lucas_m',
          email: 'lucas@gmail.com',
          avatarUrl: 'https://picsum.photos/400/320',
        ),
      ],
    ),
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
      channels: [],
      members: [],
    ),
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
      channels: [],
      members: [],
    ),
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
