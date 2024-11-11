import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../common/enums.dart';
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Colors.grey.shade300),
                          ),
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
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton.icon(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 24),
                          backgroundColor:
                              Theme.of(context).primaryColor.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.camera_alt_outlined,
                            color: Colors.blueAccent),
                        label: const Text(
                          'Choose Image',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        onPressed: () async {
                          final imagePicker = ImagePicker();
                          try {
                            final imageFile = await imagePicker.pickImage(
                              source: ImageSource.gallery,
                            );
                            if (imageFile == null) {
                              return;
                            }
                            setModalState(() {
                              _editedUser = _editedUser.copyWith(
                                  avatar: File(imageFile.path));
                            });
                          } catch (error) {
                            if (context.mounted) {
                              showInfoDialog(
                                confirmText: 'Something went wrong',
                                context: context,
                                status: StatusType.error,
                              );
                            }
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          _onChangeAvatar();
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
