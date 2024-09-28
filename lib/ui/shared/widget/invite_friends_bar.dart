import 'package:flutter/material.dart';

import '../../../models/user.dart';
import 'customized_text_field.dart';

class InviteFriendsBar extends StatefulWidget {
  const InviteFriendsBar({super.key});
  @override
  State<InviteFriendsBar> createState() => _FriendSearchBarState();
}

class _FriendSearchBarState extends State<InviteFriendsBar> {
  final List<User> friends = [
    User(
      id: '1',
      fullName: 'John Doe',
      userName: 'johndoe',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '1',
      fullName: 'John Doe',
      userName: 'johndoe',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '1',
      fullName: 'John Doe',
      userName: 'johndoe',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '1',
      fullName: 'John Doe',
      userName: 'johndoe',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
    User(
      id: '1',
      fullName: 'John Doe',
      userName: 'johndoe',
      email: 'johndoe@me.com',
      avatarUrl: 'https://picsum.photos/200',
    ),
  ];
  List<User> filteredFriends = []; // List of filtered friends

  void _filterFriends(String query) {
    if (query.isEmpty) {
      filteredFriends = [];
    } else {
      filteredFriends = friends
          .where((friends) =>
              friends.userName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250.0,
      width: double.infinity,
      child: Column(
        children: [
          CustomizedTextField(
            onChanged: _filterFriends,
            labelText: 'Search',
            hintText: 'Your friend\'s username',
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: filteredFriends.isNotEmpty
                      ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
                      : Theme.of(context).colorScheme.surface,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                  )),
              child: ListView.builder(
                  itemCount: filteredFriends.length,
                  itemBuilder: (ctx, idx) {
                    return ListTile(
                      iconColor: Theme.of(context).colorScheme.onSurface,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 5.0),
                      onTap: () {
                        //TODO: Go to profile
                        print('Go to profile of ${filteredFriends[idx]}');
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.network(
                          filteredFriends[idx].avatarUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        filteredFriends[idx].userName,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            //TODO: Add this guy
                            print('Add this guy');
                          },
                          icon: const Icon(Icons.add)),
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
