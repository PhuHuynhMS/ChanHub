import 'dart:io';

import 'package:flutter/foundation.dart';

import '../services/index.dart';
import '../models/index.dart';

class WorkspacesManager with ChangeNotifier {
  final WorkspaceService _workspaceService = WorkspaceService();

  List<Workspace> _workspaces = [];
  String? _selectedWorkspaceId;
  String? _defaultWorkspaceId;

  Future<void> fetchWorkspaces() async {
    _workspaces = await _workspaceService.fetchAllWorkspaces();
    _defaultWorkspaceId = await _workspaceService.getDefaultWorkspace() ??
        _workspaces.firstOrNull?.id;
    _selectedWorkspaceId = _defaultWorkspaceId;
    notifyListeners();
  }

  Future<String?> addWorkspace(
    String workspaceName,
    File image,
    List<User> members,
  ) async {
    final newWorkspace = await _workspaceService.addWorkspace(
      workspaceName,
      image,
      members,
    );
    if (_defaultWorkspaceId == null) {
      await setDefaultWorkspace(newWorkspace!);
    }
    _workspaces.add(newWorkspace!);
    setSelectedWorkspace(newWorkspace.id);
    notifyListeners();
    return newWorkspace.id;
  }

  Future<void> deleteWorkspace(String workspaceId) async {
    await _workspaceService.deleteWorkspace(workspaceId);

    _workspaces.removeWhere((workspace) => workspace.id == workspaceId);

    if (workspaceId == _defaultWorkspaceId) {
      _defaultWorkspaceId = _workspaces.isNotEmpty ? _workspaces.last.id : null;
    }

    _selectedWorkspaceId = _defaultWorkspaceId;

    notifyListeners();
  }

  Future<bool> deleteWorkspaceMember(User member) async {
    await _workspaceService.deleteWorkspaceMembers(
      member.id,
      _selectedWorkspaceId!,
    );
    notifyListeners();
    return true;
  }

  bool isWorkspaceAdmin(String userId) {
    return userId == getSelectedWorkspace()?.creator.id;
  }

  Future<void> addWorkspaceMembers(
    List<User> members,
    String workspaceId,
  ) async {
    await _workspaceService.addWorkspaceMembers(members, workspaceId);
  }

  Workspace? getSelectedWorkspace() {
    if (_selectedWorkspaceId == null) return null;
    return _workspaces
        .firstWhere((workspace) => workspace.id == _selectedWorkspaceId);
  }

  void setSelectedWorkspace(String newWorkspaceId) {
    _selectedWorkspaceId = newWorkspaceId;
    notifyListeners();
  }

  Future<void> fetchSelectedWorkspace() async {
    final newSelectedWorkspace =
        await _workspaceService.fetchWorkspace(_selectedWorkspaceId!);
    final index = _workspaces.indexOf(getSelectedWorkspace()!);
    _workspaces[index] = newSelectedWorkspace!;
    notifyListeners();
  }

  Workspace? getDefaultWorkspace() {
    if (_defaultWorkspaceId == null) return null;
    return _workspaces
        .firstWhere((workspace) => workspace.id == _defaultWorkspaceId);
  }

  Future<void> setDefaultWorkspace(Workspace newWorkspace) async {
    await _workspaceService.setDefaultWorkspace(
      getDefaultWorkspace(),
      newWorkspace,
    );
    _defaultWorkspaceId = newWorkspace.id;
    notifyListeners();
  }

  List<Workspace> getAll() {
    return [..._workspaces];
  }

  List<User> getAllMembers() {
    final selectedworkspace = getSelectedWorkspace();
    if (selectedworkspace != null) {
      return [...selectedworkspace.members];
    }
    return [];
  }

  String? getSelectedWorkspaceId() {
    return _selectedWorkspaceId;
  }

  void add(Workspace workspace) {
    _workspaces.add(workspace);
  }

  void update(Workspace workspace) {
    final index = _workspaces.indexWhere((w) => w.id == workspace.id);
    if (index != -1) {
      _workspaces[index] = workspace;
    }
  }

  void delete(Workspace workspace) {
    _workspaces.remove(workspace);
  }

  Workspace? getById(String id) {
    try {
      return _workspaces.firstWhere((w) => w.id == id);
    } catch (e) {
      return null;
    }
  }
}
