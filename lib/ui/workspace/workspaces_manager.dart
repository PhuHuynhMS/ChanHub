import '../../models/workspace.dart';
import '../../models/channel.dart';
import '../../models/user.dart';
import '../../common/enums.dart';

class WorkspacesManager {
  List<Workspace> workspaces = [
    Workspace(
        name: 'Banana workspace',
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
        channels: [
          Channel(
              id: '1',
              name: 'Banana channel',
              description: 'This is the Banana channel',
              privacy: ChannelPrivacy.public,
              creatorId: '1',
              createdAt: DateTime.now(),
              memberCount: 0,
              creator: User(
                id: '1',
                fullName: 'John Doe',
                userName: 'johndoe',
                avatarUrl: 'https://picsum.photos/300/300',
                email: 'john@gmail.com',
              ))
        ]),
    Workspace(
        name: 'Pineapple workspace',
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
        channels: [
          Channel(
              id: '1',
              name: 'Banana channel',
              description: 'This is the Banana channel',
              privacy: ChannelPrivacy.public,
              creatorId: '1',
              createdAt: DateTime.now(),
              memberCount: 0,
              creator: User(
                id: '1',
                fullName: 'John Doe',
                userName: 'johndoe',
                avatarUrl: 'https://picsum.photos/300/300',
                email: 'john@gmail.com',
              ))
        ]),
    Workspace(
        name: 'Grape workspace',
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
    return workspaces.firstWhere((w) => w.id == id,
        orElse: () => Workspace(
              name: '',
              createdBy: User(
                  id: '', fullName: '', userName: '', email: '', avatarUrl: ''),
              createdAt: DateTime.now(),
              id: '',
              imageUrl: '',
              channels: [],
            ));
  }
}
