import 'package:pocketbase/pocketbase.dart';

import '../models/index.dart';
import './index.dart';

class WorkspaceService {
  String _getImageUrl(PocketBase pb, RecordModel workspaceModel) {
    final imageName = workspaceModel.getStringValue('image');
    return pb.files.getUrl(workspaceModel, imageName).toString();
  }

  Future<List<Workspace>> fetchAllWorkspaces() async {
    final List<Workspace> workspaces = [];
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model!.id;
      final workspaceModels = await pb.collection("workspaces").getFullList(
            filter:
                "workspace_members_via_workspace.member.id ?= '$userId' && workspace_members_via_workspace.status ?= 'accepted' && workspace_members_via_workspace.deleted ?= null",
            expand: "creator,workspace_members_via_workspace.member",
          );

      for (final workspaceModel in workspaceModels) {
        workspaces.add(Workspace.fromJson(workspaceModel.toJson()
          ..addAll({
            'imageUrl': _getImageUrl(pb, workspaceModel),
          })));
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
                "member.id = '$userId' && status = 'accepted' && deleted = null && is_default = true",
                expand: "workspace",
              );
      return workspaceModels.toJson()['expand']['workspace']['id'] as String;
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<void> setDefaultWorkspace(Workspace newDefaultWorkspace) async {
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model!.id;

      final oldWorkspaceMemberModel = await pb
          .collection('workspace_members')
          .getFirstListItem(
              "member.id = '$userId' && is_default=true && deleted=null && status='accepted'");
      final oldSelectedWorkspaceId = oldWorkspaceMemberModel.toJson()['id'];

      final oldRecord = await pb
          .collection('workspace_members')
          .update(oldSelectedWorkspaceId, body: {
        "is_default": false,
      });

      final newWorkspaceMemberModel = await pb
          .collection('workspace_members')
          .getFirstListItem(
              "member.id = '$userId' && is_default = false && workspace.id = '${newDefaultWorkspace.id}' && deleted=null && status='accepted'");
      final newSelectedWorkspaceId = newWorkspaceMemberModel.toJson()['id'];

      final newRecord = await pb
          .collection('workspace_members')
          .update(newSelectedWorkspaceId, body: {
        "is_default": true,
      });
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }
}
