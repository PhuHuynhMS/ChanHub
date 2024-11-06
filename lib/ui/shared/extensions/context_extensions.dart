import 'package:flutter/material.dart';

import '../../../common/enums.dart';
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
