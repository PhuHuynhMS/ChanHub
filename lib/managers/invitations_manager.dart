import '../models/index.dart';

class InvitationsManager {
  final List<Invitation> _invitations = [];

  List<Invitation> getAll() {
    return [..._invitations];
  }

  int count() {
    return _invitations.length;
  }

  void add(Invitation invitation) {
    _invitations.add(invitation);
  }

  Invitation? getById(String invitationId) {
    try {
      return _invitations.firstWhere((c) => c.id == invitationId);
    } catch (error) {
      return null;
    }
  }
}
