import 'dart:io';

import 'package:flutter/foundation.dart';

import '../services/index.dart';
import '../models/index.dart';

class WorkspacesManager with ChangeNotifier {
  final WorkspaceService _workspaceService = WorkspaceService();

  List<Workspace> _workspaces = [];
  String? _selectedWorkspaceId;
  String? _defaultWorkspaceId;
  List<User> _members = [];

  Future<void> fetchWorkspaces() async {
    _workspaces = await _workspaceService.fetchAllWorkspaces();
    _defaultWorkspaceId = await _workspaceService.getDefaultWorkspace();
    _selectedWorkspaceId = _defaultWorkspaceId;
    notifyListeners();
  }

  Future<String?> addWorkspace(String workspaceName, File image) async {
    final newWorkspace =
        await _workspaceService.addWorkspace(workspaceName, image);
    if (newWorkspace != null) {
      _workspaces.add(newWorkspace);
      await setSelectedWorkspace(newWorkspace.id);
      notifyListeners();
      return newWorkspace.id;
    }
    return null;
  }

  Future<void> fetchWorkspaceMembers() async {
    _members = await _workspaceService.fetchAllWorkspaceMembers();
    notifyListeners();
  }

  Future<void> addWorkspaceMembers(
      List<User> members, String workspaceId) async {
    await _workspaceService.addWorkspaceMembers(members, workspaceId);
  }

  Workspace? getSelectedWorkspace() {
    if (_selectedWorkspaceId == null) return null;
    return _workspaces
        .firstWhere((workspace) => workspace.id == _selectedWorkspaceId);
  }

  Future<void> setSelectedWorkspace(String newWorkspaceId) async {
    _selectedWorkspaceId = newWorkspaceId;
    notifyListeners();
  }

  Workspace? getDefaultWorkspace() {
    if (_defaultWorkspaceId == null) return null;
    return _workspaces
        .firstWhere((workspace) => workspace.id == _defaultWorkspaceId);
  }

  Future<void> setDefaultWorkspace(Workspace newWorkspace) async {
    await _workspaceService.setDefaultWorkspace(newWorkspace);
    _defaultWorkspaceId = newWorkspace.id;
    notifyListeners();
  }

  List<Workspace> getAll() {
    return [..._workspaces];
  }

  List<User> getAllMembers() {
    return [..._members];
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
