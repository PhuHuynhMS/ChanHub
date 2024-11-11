import '../models/index.dart';
import './index.dart';

class InvitationService {
  Future<List<Invitation>> fetchAllInvitations() async {
    try {
      final pb = await PocketBaseService.getInstance();
      final userId = pb.authStore.model.id;
      final invitationModels =
          await pb.collection('workspace_invitations').getFullList(
                filter: "member = '$userId'",
                expand: 'workspace, workspace.creator,'
                    'workspace.accepted_workspace_members_via_workspace.member,'
                    'workspace.workspace_invitations_via_workspace.member',
              );
      if (invitationModels.isNotEmpty) {
        return invitationModels
            .map((model) => Invitation.fromJson(model.toJson()))
            .toList();
      }
      return [];
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<void> acceptedInvitation(String memberWorkspaceId) async {
    try {
      final pb = await PocketBaseService.getInstance();

      await pb
          .collection('workspace_members')
          .update(memberWorkspaceId, body: {'status': 'accepted'});
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }

  Future<void> ignoredInvitation(String memberWorkspaceId) async {
    try {
      final pb = await PocketBaseService.getInstance();

      await pb.collection('workspace_members').delete(memberWorkspaceId);
    } on Exception catch (exception) {
      throw ServiceException(exception);
    }
  }
}
