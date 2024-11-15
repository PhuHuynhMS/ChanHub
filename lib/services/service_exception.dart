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

  int get statusCode {
    if (exception is ClientException) {
      final ClientException clientException = exception as ClientException;
      if ((clientException.statusCode == 400 &&
              clientException.response['message'] ==
                  'Failed to create record.') ||
          (clientException.statusCode == 404 &&
              clientException.response['message'] ==
                  'The requested resource wasn\'t found.')) {
        return 403;
      }
      return clientException.statusCode;
    }
    return 500;
  }

  String _getSingleMessage() {
    if (statusCode == 403) {
      return 'You do not have permission to perform this action.';
    }
    if (statusCode == 429) {
      return 'Too many requests. Please try again later.';
    }
    if (statusCode == 400 &&
        exception is ClientException &&
        (exception as ClientException).response['message'] ==
            'Failed to authenticate.') {
      return 'Username or password is incorrect.';
    }
    if (exception is ClientException) {
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
