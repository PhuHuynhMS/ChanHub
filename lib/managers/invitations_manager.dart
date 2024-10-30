import '../models/index.dart';

class InvitationsManager {
  final List<Invitation> _invitations = [
    Invitation(
        id: '1',
        workspace: Workspace(
          name: 'ChanHub Developer',
          createdBy: User(
            jobTitle: "Flutter Developer",
            id: '1',
            fullname: 'John Doe',
            username: 'johndoe',
            avatarUrl: 'https://picsum.photos/400/300',
            email: 'john@gmail.com',
          ),
          createdAt: DateTime.now(),
          id: '1',
          imageUrl: 'https://picsum.photos/400/300',
          members: [
            User(
              jobTitle: "Flutter Developer",
              id: '1',
              fullname: 'John Smith',
              username: 'john_smith',
              email: 'johnsmith@gmail.com',
              avatarUrl: 'https://picsum.photos/400/300',
            ),
            User(
              jobTitle: "Flutter Developer",
              id: '2',
              fullname: 'Emily Brown',
              username: 'emily_brown',
              email: 'emily@gmail.com',
              avatarUrl: 'https://picsum.photos/350/300',
            ),
            User(
              jobTitle: "Flutter Developer",
              id: '3',
              fullname: 'Michael Johnson',
              username: 'michael_j',
              email: 'michael@gmail.com',
              avatarUrl: 'https://picsum.photos/420/320',
            ),
            User(
              jobTitle: "Flutter Developer",
              id: '4',
              fullname: 'Sophia White',
              username: 'sophia_w',
              email: 'sophia@gmail.com',
              avatarUrl: 'https://picsum.photos/400/400',
            ),
            User(
              jobTitle: "Flutter Developer",
              id: '5',
              fullname: 'David Wilson',
              username: 'david_w',
              email: 'david@gmail.com',
              avatarUrl: 'https://picsum.photos/450/300',
            ),
            User(
              jobTitle: "Flutter Developer",
              id: '6',
              fullname: 'Olivia Lee',
              username: 'olivia_lee',
              email: 'olivia@gmail.com',
              avatarUrl: 'https://picsum.photos/380/330',
            ),
            User(
              jobTitle: "Flutter Developer",
              id: '7',
              fullname: 'Chris Martin',
              username: 'chris_m',
              email: 'chris@gmail.com',
              avatarUrl: 'https://picsum.photos/400/350',
            ),
            User(
              jobTitle: "Flutter Developer",
              id: '8',
              fullname: 'Isabella Harris',
              username: 'isabella_h',
              email: 'isabella@gmail.com',
              avatarUrl: 'https://picsum.photos/370/340',
            ),
            User(
              jobTitle: "Flutter Developer",
              id: '9',
              fullname: 'James Clark',
              username: 'james_c',
              email: 'james@gmail.com',
              avatarUrl: 'https://picsum.photos/430/300',
            ),
            User(
              jobTitle: "Flutter Developer",
              id: '10',
              fullname: 'Mia Anderson',
              username: 'mia_a',
              email: 'mia@gmail.com',
              avatarUrl: 'https://picsum.photos/400/310',
            ),
            User(
              jobTitle: "Flutter Developer",
              id: '11',
              fullname: 'Ethan Walker',
              username: 'ethan_w',
              email: 'ethan@gmail.com',
              avatarUrl: 'https://picsum.photos/420/380',
            ),
            User(
              jobTitle: "Flutter Developer",
              id: '12',
              fullname: 'Ava Taylor',
              username: 'ava_t',
              email: 'ava@gmail.com',
              avatarUrl: 'https://picsum.photos/360/390',
            ),
            User(
              jobTitle: "Flutter Developer",
              id: '13',
              fullname: 'Liam Thompson',
              username: 'liam_t',
              email: 'liam@gmail.com',
              avatarUrl: 'https://picsum.photos/410/310',
            ),
            User(
              jobTitle: "Flutter Developer",
              id: '14',
              fullname: 'Charlotte Miller',
              username: 'charlotte_m',
              email: 'charlotte@gmail.com',
              avatarUrl: 'https://picsum.photos/380/360',
            ),
            User(
              jobTitle: "Flutter Developer",
              id: '15',
              fullname: 'Lucas Moore',
              username: 'lucas_m',
              email: 'lucas@gmail.com',
              avatarUrl: 'https://picsum.photos/400/320',
            ),
          ],
        ),
        creator: User(
          jobTitle: "Flutter Developer",
          id: '15',
          fullname: 'Lucas Moore',
          username: 'lucas_m',
          email: 'lucas@gmail.com',
          avatarUrl: 'https://picsum.photos/400/320',
        ),
        createdAt: DateTime.now()),
    Invitation(
        id: '2',
        workspace: Workspace(
          name: 'Pineapple and Banana',
          createdBy: User(
            jobTitle: "Flutter Developer",
            id: '1',
            fullname: 'John Doe',
            username: 'johndoe',
            avatarUrl: 'https://picsum.photos/500/300',
            email: 'john@gmail.com',
          ),
          createdAt: DateTime.now(),
          id: '2',
          imageUrl: 'https://picsum.photos/300/300',
          members: [
            User(
              jobTitle: "Flutter Developer",
              id: '1',
              fullname: 'John Smith',
              username: 'john_smith',
              email: 'johnsmith@gmail.com',
              avatarUrl: 'https://picsum.photos/400/300',
            )
          ],
        ),
        creator: User(
          jobTitle: "Flutter Developer",
          id: '1',
          fullname: 'John Smith',
          username: 'john_smith',
          email: 'johnsmith@gmail.com',
          avatarUrl: 'https://picsum.photos/400/300',
        ),
        createdAt: DateTime.now()),
    Invitation(
        id: '3',
        workspace: Workspace(
          name: 'ABCXYZ',
          createdBy: User(
            jobTitle: "Flutter Developer",
            id: '2',
            fullname: 'Emily Brown',
            username: 'emily_brown',
            email: 'emily@gmail.com',
            avatarUrl: 'https://picsum.photos/350/300',
          ),
          createdAt: DateTime.now(),
          id: '3',
          imageUrl: 'https://picsum.photos/200/300',
          members: [
            User(
              jobTitle: "Flutter Developer",
              id: '2',
              fullname: 'Emily Brown',
              username: 'emily_brown',
              email: 'emily@gmail.com',
              avatarUrl: 'https://picsum.photos/350/300',
            )
          ],
        ),
        creator: User(
          jobTitle: "Flutter Developer",
          id: '2',
          fullname: 'Emily Brown',
          username: 'emily_brown',
          email: 'emily@gmail.com',
          avatarUrl: 'https://picsum.photos/350/300',
        ),
        createdAt: DateTime.now()),
  ];

  List<Invitation> getAll() {
    return [..._invitations];
  }

  int count() {
    return _invitations.length;
  }

  void add(Invitation invitation) {
    _invitations.add(invitation);
  }

  Invitation? getById(String invitationId) {
    try {
      return _invitations.firstWhere((c) => c.id == invitationId);
    } catch (error) {
      return null;
    }
  }
}
