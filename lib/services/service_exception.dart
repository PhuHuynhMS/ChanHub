import 'package:pocketbase/pocketbase.dart';

class ServiceException implements Exception {
  final Exception exception;
  final bool isMultiple;

  ServiceException(this.exception, {this.isMultiple = false});

  @override
  String toString() {
    return message;
  }

  String get message {
    return isMultiple ? _getMultipleMessage() : _getSingleMessage();
  }

  String _getSingleMessage() {
    if (exception is ClientException) {
      if ((exception as ClientException).statusCode == 429) {
        return 'Too many requests. Please try again later.';
      }
      final Map<String, dynamic> response =
          (exception as ClientException).response;

      final Map<String, dynamic> data = response['data'] ?? {};

      if (data.isNotEmpty) {
        for (final key in data.keys) {
          final Map<String, dynamic> field = data[key];
          if (field['message'] != null) {
            return field['message'];
          }
        }
      }

      return response['message'] ?? 'An error occurred';
    }
    return 'An error occurred';
  }

  String _getMultipleMessage() {
    if (exception is ClientException) {
      final Map<String, dynamic> response =
          (exception as ClientException).response;

      final Map<String, dynamic> data = response['data'] ?? {};

      if (data.isNotEmpty) {
        final List<String> messages = [];

        for (final key in data.keys) {
          final Map<String, dynamic> field = data[key];
          if (field['message'] != null) {
            messages.add(field['message']);
          }
        }

        return messages.join('\n');
      }

      return response['message'];
    }
    return 'An error occurred';
  }
}
