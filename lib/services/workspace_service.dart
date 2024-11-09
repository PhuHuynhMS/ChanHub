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

      final workspaceModels = await pb.collection("workspaces").getFullList(
        filter: """
                  workspace_members_via_workspace.member.id ?= '$userId' && 
                  workspace_members_via_workspace.status ?= 'accepted'
                """,
        expand:
            "creator,workspace_members_via_workspace,workspace_members_via_workspace.member",
      );

      for (final workspaceModel in workspaceModels) {
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
          await pb.collection("workspace_members").getFirstListItem(
        """
          member.id = '$userId' && 
          status = 'accepted' && 
          is_default = true
        """,
      );
      return workspaceModels.toJson()['workspace'] as String?;
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
        expand: 'creator,workspace_members_via_workspace.member',
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
            expand:
                "creator,workspace_members_via_workspace,workspace_members_via_workspace.member",
          );
      return Workspace.fromJson(selectedWorkspaceModel.toJson()
        ..addAll({
          'userId': pb.authStore.model!.id,
        }));
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<void> deleteWorkspaceMembers(
      String memberId, String workspaceId) async {
    try {
      final pb = await PocketBaseService.getInstance();

      final workspaceMemberModel =
          await pb.collection('workspace_members').getFirstListItem("""
            member = '$memberId' && 
            workspace = '$workspaceId' 
          """);
      await pb.collection('workspace_members').delete(
            workspaceMemberModel.toJson()['id'],
          );
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }
}
