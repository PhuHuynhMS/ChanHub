import '../../common/enums.dart';
import '../../models/comment.dart';
import '../../models/reaction.dart';
import '../../models/thread.dart';
import '../../models/user.dart';
import '../../models/task.dart';

class ThreadsManager {
  final List<Thread> _threads = [
    Thread(
      content: null,
      mediaUrls: [
        'https://picsum.photos/600/300',
        'https://picsum.photos/200/500',
      ],
      id: '1',
      creatorId: '1',
      createdAt: DateTime.parse('2024-09-23'),
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
          content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
          mediaUrls: <String>[
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
            ],
            ReactionType.haha: [],
            ReactionType.seen: [],
            ReactionType.completed: [],
            ReactionType.dislike: [],
          },
        ),
        Comment(
          id: '2',
          content: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
          mediaUrls: <String>[],
          creatorId: '2',
          createdAt: DateTime.now(),
          creator: User(
            id: '2',
            fullName: 'Anwir Keith',
            userName: 'anwirkeith',
            avatarUrl: 'https://picsum.photos/400/300',
            email: 'anwir@gmail.com',
          ),
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
              )
            ],
            ReactionType.haha: [],
            ReactionType.seen: [],
            ReactionType.completed: [],
            ReactionType.dislike: [],
          },
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
      createdAt: DateTime.parse('2024-09-22'),
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
          reactions: <ReactionType, List<Reaction>>{
            ReactionType.like: [],
            ReactionType.love: [],
            ReactionType.haha: [],
            ReactionType.seen: [],
            ReactionType.completed: [],
            ReactionType.dislike: [],
          },
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
          reactions: <ReactionType, List<Reaction>>{
            ReactionType.like: [],
            ReactionType.love: [],
            ReactionType.haha: [],
            ReactionType.seen: [
              Reaction(
                id: '1',
                creatorId: '1',
                type: ReactionType.seen,
                createdAt: DateTime.now(),
                creator: User(
                  id: '1',
                  fullName: 'John Doe',
                  userName: 'johndoe',
                  avatarUrl: 'https://picsum.photos/300/300',
                  email: 'john@gmail.com',
                ),
              ),
              Reaction(
                id: '2',
                creatorId: '2',
                type: ReactionType.seen,
                createdAt: DateTime.now(),
                creator: User(
                    id: '2',
                    fullName: 'Anwir Keith',
                    userName: 'anwirkeith',
                    avatarUrl: 'https://picsum.photos/400/300',
                    email: 'anwir@gmail.com'),
              ),
            ],
            ReactionType.completed: [],
            ReactionType.dislike: [],
          },
        ),
      ],
    ),
    Thread(
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      mediaUrls: [
        'https://picsum.photos/700/700',
        'https://picsum.photos/800/500',
      ],
      id: '3',
      creatorId: '1',
      createdAt: DateTime.parse('2024-09-21'),
      reactions: <ReactionType, List<Reaction>>{
        ReactionType.like: [
          Reaction(
            id: '10',
            creatorId: '3',
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
        id: '2',
        fullName: 'Yuya Keith',
        userName: 'yuyakeith',
        avatarUrl: 'https://picsum.photos/600/600',
        email: 'yuya@gmail.com',
      ),
      comments: <Comment>[],
    ),
    Thread(
      content:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      mediaUrls: [
        'https://picsum.photos/800/800',
        'https://picsum.photos/800/600',
      ],
      id: '4',
      creatorId: '1',
      createdAt: DateTime.parse('2024-09-21'),
      reactions: <ReactionType, List<Reaction>>{
        ReactionType.like: [
          Reaction(
            id: '10',
            creatorId: '3',
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
        id: '2',
        fullName: 'Yuya Keith',
        userName: 'yuyakeith',
        avatarUrl: 'https://picsum.photos/600/600',
        email: 'yuya@gmail.com',
      ),
      comments: <Comment>[],
      tasks: [
        Task(
          id: '1',
          title: 'Complete the first task',
          description:
              'This is the first task that you need to complete. It is very important to complete this task as soon as possible.',
          assignee: User(
            id: '1',
            fullName: 'John Doe',
            userName: 'johndoe',
            avatarUrl: 'https://picsum.photos/300/300',
            email: 'john@gmail.com',
          ),
          deadline: DateTime(2021, 9, 30),
        ),
        Task(
          id: '2',
          title: 'FE UI/UX Design',
          description:
              'Design a new UI/UX for the new feature. The design should be user-friendly and easy to use.',
          assignee: User(
            id: '1',
            fullName: 'John Doe',
            userName: 'johndoe',
            avatarUrl: 'https://picsum.photos/300/300',
            email: 'john@gmail.com',
          ),
          deadline: DateTime(2024, 10, 4),
        ),
        Task(
          id: '3',
          title: 'BE API',
          description:
              'Design a new UI/UX for the new feature. The design should be user-friendly and easy to use.',
          assignee: User(
            id: '1',
            fullName: 'John Doe',
            userName: 'johndoe',
            avatarUrl: 'https://picsum.photos/300/300',
            email: 'john@gmail.com',
          ),
          deadline: DateTime(2024, 10, 15),
        ),
        Task(
          id: '4',
          title: 'FE API Integration',
          description:
              'Design a new UI/UX for the new feature. The design should be user-friendly and easy to use.',
          assignee: User(
            id: '1',
            fullName: 'John Doe',
            userName: 'johndoe',
            avatarUrl: 'https://picsum.photos/300/300',
            email: 'john@gmail.com',
          ),
          deadline: DateTime(2024, 10, 20),
        ),
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
