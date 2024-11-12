import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/index.dart';
import './index.dart';

class WorkspaceService {
  Future<List<Workspace>> fetchAllWorkspaces() async {
    final List<Workspace> workspaces = [];
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model!.id;

      final workspaceMemberModels =
          await pb.collection("accepted_workspace_members").getFullList(
                filter: "member = '$userId'",
                expand: 'workspace.creator,'
                    'workspace.accepted_workspace_members_via_workspace.member,'
                    'workspace.workspace_invitations_via_workspace.member',
              );

      for (final workspaceMemberModel in workspaceMemberModels) {
        final workspaceModel = workspaceMemberModel.expand['workspace']!.first;
        workspaces.add(Workspace.fromJson(workspaceModel.toJson()
          ..addAll({
            'userId': userId,
          })));
      }
      return workspaces;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<String?> getDefaultWorkspace() async {
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model!.id;
      final workspaceModels =
          await pb.collection("workspace_members").getFullList(
                filter: "member.id = '$userId' && "
                    "status = 'accepted' && is_default = true",
              );
      if (workspaceModels.isEmpty) {
        return null;
      }

      return workspaceModels[0].toJson()['workspace'] as String?;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<void> setDefaultWorkspace(
    Workspace? oldDefaultWorkspace,
    Workspace newDefaultWorkspace,
  ) async {
    try {
      final pb = await PocketBaseService.getInstance();
      if (oldDefaultWorkspace != null) {
        await pb.collection('workspace_members').update(
          oldDefaultWorkspace.workspaceMemberId!,
          body: {
            'is_default': false,
          },
        );
      }

      await pb.collection('workspace_members').update(
        newDefaultWorkspace.workspaceMemberId!,
        body: {
          'is_default': true,
        },
      );
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<Workspace?> addWorkspace(
      String workspaceName, File image, List<User> members) async {
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = await pb.authStore.model.id;
      final user = await pb.authStore.model;
      final workspaceModel = await pb.collection('workspaces').create(
        body: {
          'name': workspaceName,
          'creator': userId,
        },
        files: [
          http.MultipartFile.fromBytes('image', await image.readAsBytes(),
              filename: image.uri.pathSegments.last)
        ],
        expand: 'creator',
      );

      await addWorkspaceMembers(
          [User.fromJson(user.toJson()), ...members], workspaceModel.id);

      return await fetchWorkspace(workspaceModel.id);
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<void> addWorkspaceMembers(
      List<User> members, String workspaceId) async {
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = await pb.authStore.model.id;

      for (final member in members) {
        final body = <String, dynamic>{
          "member": member.id,
          "workspace": workspaceId,
          "status": member.id == userId ? 'accepted' : 'pending',
        };

        await pb.collection('workspace_members').create(body: body);
      }
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<void> deleteWorkspace(String workspaceId) async {
    try {
      final pb = await PocketBaseService.getInstance();

      await pb.collection('workspaces').delete(workspaceId);
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<Workspace?> fetchWorkspace(String workspaceId) async {
    try {
      final pb = await PocketBaseService.getInstance();
      final selectedWorkspaceModel = await pb.collection('workspaces').getOne(
            workspaceId,
            expand: 'creator,'
                'accepted_workspace_members_via_workspace.member,'
                'workspace_invitations_via_workspace.member',
          );
      return Workspace.fromJson(selectedWorkspaceModel.toJson()
        ..addAll({
          'userId': pb.authStore.model!.id,
        }));
    } on Exception catch (_) {
      return null;
    }
  }

  Future<void> deleteWorkspaceMembers(
    String memberId,
    String workspaceId,
  ) async {
    try {
      final pb = await PocketBaseService.getInstance();

      final workspaceMemberModel =
          await pb.collection('workspace_members').getFirstListItem(
                "member = '$memberId' && workspace = '$workspaceId'",
              );
      await pb.collection('workspace_members').delete(
            workspaceMemberModel.toJson()['id'],
          );
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<void> leaveWorkspace(String workspaceMemberId) async {
    try {
      final pb = await PocketBaseService.getInstance();

      await pb.collection('workspace_members').delete(workspaceMemberId);
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<Workspace?> updateWorkspace(Workspace workspace) async {
    try {
      final pb = await PocketBaseService.getInstance();
      final workspaceModel = await pb.collection('workspaces').update(
            workspace.id,
            body: workspace.toJson(),
            expand: 'creator,'
                'accepted_workspace_members_via_workspace.member,'
                'workspace_invitations_via_workspace.member',
            files: workspace.image != null
                ? [
                    http.MultipartFile.fromBytes(
                        'image', await workspace.image!.readAsBytes(),
                        filename: workspace.image!.uri.pathSegments.last)
                  ]
                : [],
          );

      return Workspace.fromJson(workspaceModel.toJson());
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }
}
