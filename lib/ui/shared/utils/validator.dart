typedef ValidatorFunction = String? Function(String? value);

class Validator {
  static ValidatorFunction compose(List<ValidatorFunction> validators) {
    return (String? value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }

  static ValidatorFunction required(String? errorMessage) {
    return (String? value) {
      if (value == null || value.trim().isEmpty) {
        return errorMessage ?? 'This field is required';
      }
      return null;
    };
  }

  static ValidatorFunction email(String? errorMessage) {
    return (String? value) {
      final RegExp emailRegExp = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      );
      if (value == null || !emailRegExp.hasMatch(value.trim())) {
        return errorMessage ?? 'Please enter a valid email address';
      }
      return null;
    };
  }

  static ValidatorFunction minLength(int length, String? errorMessage) {
    return (String? value) {
      if (value == null || value.length < length) {
        return errorMessage ?? 'This field must be at least $length characters';
      }
      return null;
    };
  }

  static ValidatorFunction maxLength(int length, String? errorMessage) {
    return (String? value) {
      if (value == null || value.length > length) {
        return errorMessage ?? 'This field must be at most $length characters';
      }
      return null;
    };
  }

  static ValidatorFunction pattern(RegExp pattern, String? errorMessage) {
    return (String? value) {
      if (value == null || !pattern.hasMatch(value)) {
        return errorMessage ?? 'Invalid input';
      }
      return null;
    };
  }

  static ValidatorFunction integer(String? errorMessage) {
    return (String? value) {
      if (value == null || int.tryParse(value) == null) {
        return errorMessage ?? 'Please enter a valid number';
      }
      return null;
    };
  }

  static ValidatorFunction match(String? value, String? errorMessage) {
    return (String? confirmValue) {
      if (confirmValue != value) {
        return errorMessage ?? 'The values do not match';
      }
      return null;
    };
  }
}
