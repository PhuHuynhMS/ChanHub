import '../../common/enums.dart';
import '../../models/comment.dart';
import '../../models/reaction.dart';
import '../../models/thread.dart';
import '../../models/user.dart';

class ThreadsManager {
  final List<Thread> _threads = [
    Thread(
      content: null,
      mediaUrls: [
        'https://picsum.photos/400/300',
        'https://picsum.photos/200/500',
      ],
      id: '1',
      creatorId: '1',
      createdAt: DateTime.now(),
      reactions: <ReactionType, List<Reaction>>{
        ReactionType.like: [
          Reaction(
            id: '1',
            creatorId: '1',
            type: ReactionType.like,
            createdAt: DateTime.now(),
            creator: User(
                id: '1',
                fullName: 'John Doe',
                userName: 'johndoe',
                avatarUrl: 'https://picsum.photos/300/300',
                email: ''),
          ),
          Reaction(
            id: '2',
            creatorId: '2',
            type: ReactionType.like,
            createdAt: DateTime.now(),
            creator: User(
              id: '2',
              fullName: 'Anwir Keith',
              userName: 'anwirkeith',
              avatarUrl: 'https://picsum.photos/400/300',
              email: 'anwir@gmail.com',
            ),
          ),
        ],
        ReactionType.love: [
          Reaction(
            id: '3',
            creatorId: '3',
            type: ReactionType.love,
            createdAt: DateTime.now(),
            creator: User(
              id: '3',
              fullName: 'Jane Doe',
              userName: 'janedoe',
              avatarUrl: 'https://picsum.photos/300/400',
              email: 'jane@gmail.com',
            ),
          ),
          Reaction(
            id: '4',
            creatorId: '4',
            type: ReactionType.love,
            createdAt: DateTime.now(),
            creator: User(
              id: '4',
              fullName: 'Anwir Keith',
              userName: 'anwirkeith',
              avatarUrl: 'https://picsum.photos/400/300',
              email: 'anwir@gmail.com',
            ),
          ),
          Reaction(
            id: '5',
            creatorId: '5',
            type: ReactionType.love,
            createdAt: DateTime.now(),
            creator: User(
              id: '5',
              fullName: 'Yuya Keith',
              userName: 'yuyakeith',
              avatarUrl: 'https://picsum.photos/400/600',
              email: 'yuya@gmail.com',
            ),
          ),
          Reaction(
            id: '6',
            creatorId: '6',
            type: ReactionType.love,
            createdAt: DateTime.now(),
            creator: User(
              id: '6',
              fullName: 'Sherry',
              userName: 'sherry',
              avatarUrl: 'https://picsum.photos/400/800',
              email: 'sherry@gmail.com',
            ),
          ),
        ],
        ReactionType.haha: [],
        ReactionType.seen: [],
        ReactionType.completed: [],
        ReactionType.dislike: [],
      },
      creator: User(
        id: '1',
        fullName: 'John Doe',
        userName: 'johndoe',
        avatarUrl: 'https://picsum.photos/300/300',
        email: 'john@gmail.com',
      ),
      comments: <Comment>[
        Comment(
          id: '1',
          content:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          mediaUrls: <String>[
            'https://picsum.photos/200/300',
            'https://picsum.photos/300/300',
          ],
          creatorId: '1',
          createdAt: DateTime.now(),
          creator: User(
            id: '1',
            fullName: 'John Doe',
            userName: 'johndoe',
            avatarUrl: 'https://picsum.photos/300/300',
            email: 'john@gmail.com',
          ),
        ),
        Comment(
          id: '2',
          content:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          mediaUrls: <String>[
            'https://picsum.photos/500/300',
            'https://picsum.photos/1000/300',
          ],
          creatorId: '2',
          createdAt: DateTime.now(),
          creator: User(
            id: '2',
            fullName: 'Anwir Keith',
            userName: 'anwirkeith',
            avatarUrl: 'https://picsum.photos/400/300',
            email: 'anwir@gmail.com',
          ),
        )
      ],
    ),
    Thread(
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      mediaUrls: <String>[
        'https://picsum.photos/300/300',
        'https://picsum.photos/400/300',
      ],
      id: '2',
      creatorId: '2',
      createdAt: DateTime.now(),
      reactions: <ReactionType, List<Reaction>>{
        ReactionType.like: [
          Reaction(
            id: '1',
            creatorId: '1',
            type: ReactionType.like,
            createdAt: DateTime.now(),
            creator: User(
                id: '1',
                fullName: 'John Doe',
                userName: 'johndoe',
                avatarUrl: 'https://picsum.photos/300/300',
                email: 'john@gmail.com'),
          ),
        ],
        ReactionType.love: [
          Reaction(
            id: '3',
            creatorId: '3',
            type: ReactionType.love,
            createdAt: DateTime.now(),
            creator: User(
              id: '3',
              fullName: 'Jane Doe',
              userName: 'janedoe',
              avatarUrl: 'https://picsum.photos/300/400',
              email: 'jane@gmail.com',
            ),
          ),
        ],
        ReactionType.haha: [],
        ReactionType.seen: [],
        ReactionType.completed: [],
        ReactionType.dislike: [],
      },
      creator: User(
          id: '2',
          fullName: 'Anwir Keith',
          userName: 'anwirkeith',
          avatarUrl: 'https://picsum.photos/400/300',
          email: 'anwir@gmail.com'),
      comments: <Comment>[
        Comment(
          id: '1',
          content:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          mediaUrls: <String>[
            'https://picsum.photos/200/300',
            'https://picsum.photos/300/300',
          ],
          creatorId: '1',
          createdAt: DateTime.now(),
          creator: User(
            id: '1',
            fullName: 'John Doe',
            userName: 'johndoe',
            avatarUrl: 'https://picsum.photos/300/300',
            email: 'john@gmail.com',
          ),
        ),
        Comment(
          id: '2',
          content:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          mediaUrls: <String>[
            'https://picsum.photos/500/300',
            'https://picsum.photos/1000/300',
          ],
          creatorId: '2',
          createdAt: DateTime.now(),
          creator: User(
              id: '2',
              fullName: 'Anwir Keith',
              userName: 'anwirkeith',
              avatarUrl: 'https://picsum.photos/400/300',
              email: 'anwir@gmail.com'),
        )
      ],
    ),
  ];

  List<Thread> getAll() {
    return [..._threads];
  }

  int count() {
    return _threads.length;
  }

  void add(Thread thread) {
    _threads.add(thread);
  }

  Thread? getById(String threadId) {
    try {
      return _threads.firstWhere((t) => t.id == threadId);
    } catch (error) {
      return null;
    }
  }
}
