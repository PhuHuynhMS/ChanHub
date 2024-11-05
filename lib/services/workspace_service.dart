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
                  workspace_members_via_workspace.status ?= 'accepted' && 
                  workspace_members_via_workspace.deleted ?= null
                """,
        expand: "creator,workspace_members_via_workspace.member",
      );

      for (final workspaceModel in workspaceModels) {
        workspaces.add(Workspace.fromJson(workspaceModel.toJson()));
      }
      return workspaces;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<String> getDefaultWorkspace() async {
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model!.id;
      final workspaceModels =
          await pb.collection("workspace_members").getFirstListItem(
        """
          member.id = '$userId' && 
          status = 'accepted' && 
          deleted = null && 
          is_default = true
        """,
      );
      return workspaceModels.toJson()['workspace'] as String;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<void> setDefaultWorkspace(Workspace newDefaultWorkspace) async {
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model!.id;

      final oldWorkspaceMemberModel =
          await pb.collection('workspace_members').getFirstListItem("""
            member.id = '$userId' && 
            is_default=true && 
            deleted=null && 
            status='accepted'
          """);
      await pb.collection('workspace_members').update(
        oldWorkspaceMemberModel.toJson()['id'],
        body: {"is_default": false},
      );

      final newWorkspaceMemberModel =
          await pb.collection('workspace_members').getFirstListItem("""
              member.id = '$userId' && 
              is_default = false && 
              workspace.id = '${newDefaultWorkspace.id}' && 
              deleted=null && 
              status='accepted'
            """);
      await pb.collection('workspace_members').update(
        newWorkspaceMemberModel.toJson()['id'],
        body: {"is_default": true},
      );
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<Workspace?> addWorkspace(String workspaceName, File image) async {
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = await pb.authStore.model.id;
      final user = await pb.authStore.model;
      final workspaceModel = await pb.collection('workspaces').create(body: {
        'name': workspaceName,
        'creator': userId,
      }, files: [
        http.MultipartFile.fromBytes('image', await image.readAsBytes(),
            filename: image.uri.pathSegments.last)
      ]);
      final workspaceJson = workspaceModel.toJson();
      workspaceJson['expand'] = {
        'workspace_members_via_workspace': [
          {
            'expand': {
              'member': user.toJson(),
            }
          }
        ],
        'creator': user.toJson(),
      };

      addWorkspaceMembers([User.fromJson(user.toJson())], workspaceModel.id);

      return Workspace.fromJson(workspaceJson);
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
        String status = "pending";
        if (member.id == userId) {
          status = 'accepted';
        }
        final body = <String, dynamic>{
          "member": member.id,
          "workspace": workspaceId,
          "status": status,
        };

        await pb.collection('workspace_members').create(body: body);
      }
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

//TODO: Need to fix
  Future<List<User>> fetchAllWorkspaceMembers() async {
    List<User> users = [];
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = await pb.authStore.model.id;

      final userModels =
          await pb.collection('users').getFullList(filter: "id != '$userId'");

      for (final userModel in userModels) {
        users.add(User.fromJson(userModel.toJson()));
      }
      return users;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }
}
