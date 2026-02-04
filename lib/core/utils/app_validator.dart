import '../constants/app_constants.dart';

/// App-wide form validation helpers. Return [null] when valid, or an error message [String].
abstract final class AppValidator {
  /// Returns an error message if [value] is null or blank.
  static String? required(String? value, [String? fieldName]) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) {
      return fieldName != null ? '$fieldName is required' : 'This field is required';
    }
    return null;
  }

  /// Validates email format. Use with [required] first if the field is mandatory.
  static String? email(String? value) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return null; // use [required] for mandatory
    if (trimmed.length > AppConstants.maxEmailLength) {
      return 'Email is too long';
    }
    final pattern = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return pattern.hasMatch(trimmed) ? null : 'Enter a valid email address';
  }

  /// Required + email in one call.
  static String? requiredEmail(String? value) {
    final requiredError = required(value, 'Email');
    if (requiredError != null) return requiredError;
    return email(value);
  }

  /// Validates password length and optional strength. Use [required] first if mandatory.
  static String? password(String? value, {int? minLength}) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return null;
    final min = minLength ?? AppConstants.minPasswordLength;
    if (trimmed.length < min) {
      return 'Password must be at least $min characters';
    }
    return null;
  }

  /// Required + password in one call.
  static String? requiredPassword(String? value, {int? minLength}) {
    final requiredError = required(value, 'Password');
    if (requiredError != null) return requiredError;
    return password(value, minLength: minLength);
  }

  /// Validates that [confirm] matches [password]. Use after validating [password].
  static String? confirmPassword(String? password, String? confirm) {
    if (confirm == null || confirm.trim().isEmpty) {
      return 'Please confirm your password';
    }
    if (password != confirm) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Validates name (non-empty, max length). Use for first/last name.
  static String? name(String? value, [String? fieldName]) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return null;
    if (trimmed.length > AppConstants.maxNameLength) {
      return fieldName != null
          ? '$fieldName must be ${AppConstants.maxNameLength} characters or less'
          : 'Must be ${AppConstants.maxNameLength} characters or less';
    }
    return null;
  }

  /// Required + name in one call.
  static String? requiredName(String? value, [String? fieldName]) {
    final requiredError = required(value, fieldName ?? 'Name');
    if (requiredError != null) return requiredError;
    return name(value, fieldName);
  }

  /// Validates minimum length.
  static String? minLength(String? value, int min, [String? fieldName]) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return null;
    if (trimmed.length < min) {
      return fieldName != null
          ? '$fieldName must be at least $min characters'
          : 'Must be at least $min characters';
    }
    return null;
  }

  /// Validates maximum length.
  static String? maxLength(String? value, int max, [String? fieldName]) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.length > max) {
      return fieldName != null
          ? '$fieldName must be $max characters or less'
          : 'Must be $max characters or less';
    }
    return null;
  }

  /// Runs [validators] in order; returns first error or null.
  static String? combine(List<String? Function()> validators) {
    for (final v in validators) {
      final error = v();
      if (error != null) return error;
    }
    return null;
  }
}
