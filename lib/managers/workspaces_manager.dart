import 'package:flutter/foundation.dart';

import '../models/index.dart';
import '../common/enums.dart';

class WorkspacesManager with ChangeNotifier {
  List<Workspace> workspaces = [
    Workspace(
      name: 'ChanHub Developer',
      createdBy: User(
        id: '1',
        fullname: 'John Doe',
        jobTitle: "Software Developer",
        username: 'johndoe',
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
      ],
      members: [
        User(
          id: '1',
          fullname: 'John Smith',
          jobTitle: "Software Developer",
          username: 'john_smith',
          email: 'johnsmith@gmail.com',
          avatarUrl: 'https://picsum.photos/400/300',
        ),
        User(
          id: '2',
          fullname: 'Emily Brown',
          jobTitle: "Software Developer",
          username: 'emily_brown',
          email: 'emily@gmail.com',
          avatarUrl: 'https://picsum.photos/350/300',
        ),
        User(
          id: '3',
          fullname: 'Michael Johnson',
          jobTitle: "Software Developer",
          username: 'michael_j',
          email: 'michael@gmail.com',
          avatarUrl: 'https://picsum.photos/420/320',
        ),
        User(
          id: '4',
          fullname: 'Sophia White',
          jobTitle: "Software Developer",
          username: 'sophia_w',
          email: 'sophia@gmail.com',
          avatarUrl: 'https://picsum.photos/400/400',
        ),
        User(
          id: '5',
          fullname: 'David Wilson',
          jobTitle: "Software Developer",
          username: 'david_w',
          email: 'david@gmail.com',
          avatarUrl: 'https://picsum.photos/450/300',
        ),
        User(
          id: '6',
          fullname: 'Olivia Lee',
          jobTitle: "Software Developer",
          username: 'olivia_lee',
          email: 'olivia@gmail.com',
          avatarUrl: 'https://picsum.photos/380/330',
        ),
        User(
          id: '7',
          fullname: 'Chris Martin',
          jobTitle: "Software Developer",
          username: 'chris_m',
          email: 'chris@gmail.com',
          avatarUrl: 'https://picsum.photos/400/350',
        ),
        User(
          id: '8',
          fullname: 'Isabella Harris',
          jobTitle: "Software Developer",
          username: 'isabella_h',
          email: 'isabella@gmail.com',
          avatarUrl: 'https://picsum.photos/370/340',
        ),
        User(
          id: '9',
          fullname: 'James Clark',
          jobTitle: "Software Developer",
          username: 'james_c',
          email: 'james@gmail.com',
          avatarUrl: 'https://picsum.photos/430/300',
        ),
        User(
          id: '10',
          fullname: 'Mia Anderson',
          jobTitle: "Software Developer",
          username: 'mia_a',
          email: 'mia@gmail.com',
          avatarUrl: 'https://picsum.photos/400/310',
        ),
        User(
          id: '11',
          fullname: 'Ethan Walker',
          jobTitle: "Software Developer",
          username: 'ethan_w',
          email: 'ethan@gmail.com',
          avatarUrl: 'https://picsum.photos/420/380',
        ),
        User(
          id: '12',
          fullname: 'Ava Taylor',
          jobTitle: "Software Developer",
          username: 'ava_t',
          email: 'ava@gmail.com',
          avatarUrl: 'https://picsum.photos/360/390',
        ),
        User(
          id: '13',
          fullname: 'Liam Thompson',
          jobTitle: "Software Developer",
          username: 'liam_t',
          email: 'liam@gmail.com',
          avatarUrl: 'https://picsum.photos/410/310',
        ),
        User(
          id: '14',
          fullname: 'Charlotte Miller',
          jobTitle: "Software Developer",
          username: 'charlotte_m',
          email: 'charlotte@gmail.com',
          avatarUrl: 'https://picsum.photos/380/360',
        ),
        User(
          id: '15',
          fullname: 'Lucas Moore',
          jobTitle: "Software Developer",
          username: 'lucas_m',
          email: 'lucas@gmail.com',
          avatarUrl: 'https://picsum.photos/400/320',
        ),
      ],
    ),
    Workspace(
      name: 'Pineapple and Banana',
      createdBy: User(
        id: '1',
        fullname: 'John Doe',
        jobTitle: "Software Developer",
        username: 'johndoe',
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
        fullname: 'John Doe',
        jobTitle: "Software Developer",
        username: 'johndoe',
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
