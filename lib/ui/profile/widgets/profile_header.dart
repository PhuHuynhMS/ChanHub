import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../../models/index.dart';
import '../../shared/utils/index.dart';
import '../../shared/extensions/index.dart';
import '../../shared/widgets/index.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader(
    this.user, {
    super.key,
  });

  final User user;

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  late User _editedUser;
  @override
  void initState() {
    _editedUser = widget.user;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User? loggedInUser = context.watch<AuthManager>().loggedInUser;
    final bool isMyProfile = loggedInUser?.id == widget.user.id;

    return Stack(
      children: [
        UserAvatar(
          widget.user,
          size: 140,
          borderRadius: 70,
          isTappable: false,
        ),
        if (isMyProfile) ...[
          // Edit button
          Positioned(
            right: -5,
            bottom: -5,
            child: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.surface,
              ),
              icon: const Icon(Icons.edit),
              onPressed: () => _showEditAvatarModal(context),
            ),
          ),
        ],
      ],
    );
  }

  void _onChangeAvatar() {
    context.executeWithErrorHandling(() async {
      await context.read<AuthManager>().updateUserInfo(_editedUser);
    });
    if (mounted) {
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  void _showEditAvatarModal(BuildContext context) {
    showActionDialog(
      title: "Change Your Avatar",
      context: context,
      children: [
        Center(
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Avatar preview
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(70),
                      child: _editedUser.avatar == null
                          ? Image.network(
                              _editedUser.avatarUrl,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _editedUser.avatar!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Choose from gallery
                  SizedBox(
                    child: TextButton.icon(
                      icon: const Icon(Icons.camera_alt_outlined),
                      label: Text(
                        'Choose from gallery',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      onPressed: () async {
                        final image = await showImagePicker(context);
                        _editedUser = _editedUser.copyWith(avatar: image);
                        setModalState(() {});
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 10),

        // Action buttons
        Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      )),
            ),
            TextButton(
              onPressed: () => _onChangeAvatar(),
              child: const Text('Save'),
            ),
          ],
        ),
      ],
    );
  }
}
