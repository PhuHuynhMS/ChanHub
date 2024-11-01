import '../services/index.dart';
import 'package:flutter/foundation.dart';

import '../models/index.dart';

class WorkspacesManager with ChangeNotifier {
  final WorkspaceService _workspaceService = WorkspaceService();
  final ChannelService _channelService = ChannelService();

  List<Workspace> _workspaces = [];
  String? _selectedWorkspaceId;
  String? _defaultWorkspaceId;

  Future<void> fetchWorkspaces() async {
    _workspaces = await _workspaceService.fetchAllWorkspaces();
    _defaultWorkspaceId = await _workspaceService.getDefaultWorkspace();
    _selectedWorkspaceId = _defaultWorkspaceId;
    notifyListeners();
  }

  Workspace? getDefaultWorkspace() {
    if (_defaultWorkspaceId == null) return null;
    return _workspaces
        .firstWhere((workspace) => workspace.id == _defaultWorkspaceId);
  }

  Workspace? getSelectedWorkspace() {
    if (_selectedWorkspaceId == null) return null;
    return _workspaces
        .firstWhere((workspace) => workspace.id == _selectedWorkspaceId);
  }

  Future<void> setSelectedWorkspace(Workspace newWorkspace) async {
    _selectedWorkspaceId = newWorkspace.id;
    notifyListeners();
  }

  Future<void> setDefaultWorkspace(Workspace newWorkspace) async {
    await _workspaceService.setDefaultWorkspace(newWorkspace);
    _defaultWorkspaceId = newWorkspace.id;
    notifyListeners();
  }

  List<Workspace> getAll() {
    return [..._workspaces];
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
