import 'package:flutter/material.dart';

import '../models/index.dart';
import '../services/invitation_service.dart';

class InvitationsManager with ChangeNotifier {
  final InvitationService _invitationService = InvitationService();

  List<Invitation> _invitations = [];

  Future<void> fetchInvitations() async {
    _invitations = await _invitationService.fetchAllInvitations();
    notifyListeners();
  }

  Future<void> acceptedInvitation(String memberWorkspaceId) async {
    await _invitationService.acceptedInvitation(memberWorkspaceId);
    _invitations
        .removeWhere((invitation) => invitation.id == memberWorkspaceId);
    notifyListeners();
  }

  Future<void> ignoredInvitation(String memberWorkspaceId) async {
    await _invitationService.ignoredInvitation(memberWorkspaceId);
    _invitations
        .removeWhere((invitation) => invitation.id == memberWorkspaceId);
    notifyListeners();
  }

  List<Invitation> getAll() {
    return [..._invitations];
  }

  int count() {
    return _invitations.length;
  }
}
