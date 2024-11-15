import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../managers/index.dart';
import '../../../common/enums.dart';
import '../../../services/index.dart';
import '../utils/index.dart';

extension ContextExtensions on BuildContext {
  Future<T> executeWithErrorHandling<T>(
    Future<T> Function() operation, {
    bool isShowLoading = true,
    bool ignoreError = false,
  }) async {
    if (isShowLoading) {
      showLoadingOverlay(this);
    }

    try {
      return await operation();
    } catch (error) {
      if (error is ServiceException) {
        if (error.statusCode == 401) {}
        if (error.statusCode == 403) {
          read<WorkspacesManager>().fetchWorkspaces();
          Navigator.of(this).popUntil((route) => route.isFirst);
        }
      }
      showInfoDialog(
        context: this,
        title: 'Error',
        content: Text(error.toString()),
        status: StatusType.error,
      );
    } finally {
      if (isShowLoading) {
        hideLoadingOverlay(this);
      }
    }
    return Future.value();
  }
}
