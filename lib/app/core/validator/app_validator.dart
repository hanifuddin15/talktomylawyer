import 'package:flutter/material.dart';

/// Unified Validator Class for common validation scenarios
class AppValidator {
  // Private constructor to prevent instantiation
  AppValidator._();

  // ==================== REQUIRED VALIDATION ====================

  /// Validates that a field is not empty
  static String? validateRequired(
    String? value, {
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // ==================== EMAIL VALIDATION ====================

  /// Validates email format
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validates email with custom domain whitelist
  static String? validateEmailWithDomains(
    String? value,
    List<String> allowedDomains,
  ) {
    final emailError = validateEmail(value);
    if (emailError != null) return emailError;

    final domain = value!.trim().split('@').last;
    if (!allowedDomains.contains(domain.toLowerCase())) {
      return 'Email must be from one of these domains: ${allowedDomains.join(', ')}';
    }

    return null;
  }

  // ==================== PHONE VALIDATION ====================

  /// Validates phone number (basic)
  static String? validatePhone(String? value, {bool isRequired = true}) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? 'Phone number is required' : null;
    }

    // Remove all non-digit characters
    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');

    // Check length (adjust min/max as needed)
    if (digitsOnly.length < 10) {
      return 'Please enter a valid phone number (minimum 10 digits)';
    }

    if (digitsOnly.length > 15) {
      return 'Phone number is too long';
    }

    return null;
  }

  /// Validates phone number with specific country code
  static String? validatePhoneWithCountryCode(
    String? value, {
    required String countryCode,
    int minLength = 10,
    int maxLength = 15,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');

    // Check if starts with country code
    if (!digitsOnly.startsWith(countryCode)) {
      return 'Phone number must start with $countryCode';
    }

    final numberWithoutCode = digitsOnly.substring(countryCode.length);

    if (numberWithoutCode.length < minLength) {
      return 'Phone number must be at least $minLength digits';
    }

    if (numberWithoutCode.length > maxLength) {
      return 'Phone number cannot exceed $maxLength digits';
    }

    return null;
  }

  // ==================== PASSWORD VALIDATION ====================

  /// Validates password strength
  static String? validatePassword(
    String? value, {
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumbers = true,
    bool requireSpecialChars = true,
  }) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    if (requireUppercase && !value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (requireLowercase && !value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    if (requireNumbers && !value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    if (requireSpecialChars &&
        !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  /// Validates password confirmation
  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  // ==================== NUMBER VALIDATION ====================

  /// Validates numeric input
  static String? validateNumber(
    String? value, {
    bool isRequired = true,
    double? min,
    double? max,
    bool allowDecimal = true,
  }) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? 'This field is required' : null;
    }

    // Check if it's a valid number
    final number = allowDecimal
        ? double.tryParse(value.trim())
        : int.tryParse(value.trim())?.toDouble();

    if (number == null) {
      return 'Please enter a valid ${allowDecimal ? 'number' : 'whole number'}';
    }

    if (min != null && number < min) {
      return 'Value must be at least $min';
    }

    if (max != null && number > max) {
      return 'Value must not exceed $max';
    }

    return null;
  }

  // ==================== TEXT VALIDATION ====================

  /// Validates text with custom rules
  static String? validateText(
    String? value, {
    bool isRequired = true,
    int? minLength,
    int? maxLength,
    RegExp? pattern,
    String fieldName = 'This field',
  }) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? '$fieldName is required' : null;
    }

    final trimmedValue = value.trim();

    if (minLength != null && trimmedValue.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }

    if (maxLength != null && trimmedValue.length > maxLength) {
      return '$fieldName must not exceed $maxLength characters';
    }

    if (pattern != null && !pattern.hasMatch(trimmedValue)) {
      return 'Please enter a valid $fieldName';
    }

    return null;
  }

  // ==================== URL VALIDATION ====================

  /// Validates URL format
  static String? validateUrl(String? value, {bool isRequired = true}) {
    if (value == null || value.trim().isEmpty) {
      return isRequired ? 'URL is required' : null;
    }

    final urlRegex = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
      caseSensitive: false,
    );

    if (!urlRegex.hasMatch(value.trim())) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  // ==================== DATE VALIDATION ====================

  /// Validates date
  static String? validateDate(
    DateTime? value, {
    bool isRequired = true,
    DateTime? minDate,
    DateTime? maxDate,
  }) {
    if (value == null) {
      return isRequired ? 'Date is required' : null;
    }

    if (minDate != null && value.isBefore(minDate)) {
      return 'Date must be on or after ${_formatDate(minDate)}';
    }

    if (maxDate != null && value.isAfter(maxDate)) {
      return 'Date must be on or before ${_formatDate(maxDate)}';
    }

    return null;
  }

  // ==================== AGE VALIDATION ====================

  /// Validates age (useful for birthdates)
  static String? validateAge(
    DateTime? birthDate, {
    int minAge = 18,
    int maxAge = 120,
  }) {
    if (birthDate == null) {
      return 'Birth date is required';
    }

    final today = DateTime.now();
    int age = today.year - birthDate.year;

    // Adjust age if birthday hasn't occurred this year yet
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    if (age < minAge) {
      return 'You must be at least $minAge years old';
    }

    if (age > maxAge) {
      return 'Please enter a valid birth date';
    }

    return null;
  }

  // ==================== CREDIT CARD VALIDATION ====================

  /// Validates credit card number (Luhn algorithm)
  static String? validateCreditCard(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Credit card number is required';
    }

    final digitsOnly = value.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length < 13 || digitsOnly.length > 19) {
      return 'Please enter a valid credit card number';
    }

    // Luhn algorithm
    int sum = 0;
    bool alternate = false;

    for (int i = digitsOnly.length - 1; i >= 0; i--) {
      int digit = int.parse(digitsOnly[i]);

      if (alternate) {
        digit *= 2;
        if (digit > 9) {
          digit = (digit % 10) + 1;
        }
      }

      sum += digit;
      alternate = !alternate;
    }

    if (sum % 10 != 0) {
      return 'Please enter a valid credit card number';
    }

    return null;
  }

  /// Detects credit card type
  static String detectCreditCardType(String? number) {
    if (number == null || number.isEmpty) return 'Unknown';

    final cleanNumber = number.replaceAll(RegExp(r'\D'), '');

    if (cleanNumber.startsWith('4')) return 'Visa';
    if (RegExp(r'^5[1-5]').hasMatch(cleanNumber)) return 'Mastercard';
    if (RegExp(r'^3[47]').hasMatch(cleanNumber)) return 'Amex';
    if (RegExp(r'^6011|^65|^64[4-9]').hasMatch(cleanNumber)) return 'Discover';
    if (RegExp(r'^35(2[89]|[3-8][0-9])').hasMatch(cleanNumber)) return 'JCB';

    return 'Unknown';
  }

  // ==================== ZIP/POSTAL CODE VALIDATION ====================

  /// Validates postal code based on country
  static String? validatePostalCode(
    String? value, {
    String countryCode = 'US',
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Postal code is required';
    }

    RegExp pattern;

    switch (countryCode.toUpperCase()) {
      case 'US':
        pattern = RegExp(r'^\d{5}(-\d{4})?$');
        break;
      case 'UK':
        pattern = RegExp(r'^[A-Z]{1,2}\d[A-Z\d]? \d[A-Z]{2}$');
        break;
      case 'CA':
        pattern = RegExp(r'^[A-Z]\d[A-Z] \d[A-Z]\d$');
        break;
      default:
        pattern = RegExp(r'^[A-Z0-9]{3,10}$');
    }

    if (!pattern.hasMatch(value.trim().toUpperCase())) {
      return 'Please enter a valid postal code';
    }

    return null;
  }

  // ==================== USERNAME VALIDATION ====================

  /// Validates username
  static String? validateUsername(
    String? value, {
    int minLength = 3,
    int maxLength = 20,
    bool allowUnderscore = true,
    bool allowDot = true,
  }) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }

    if (value.length < minLength) {
      return 'Username must be at least $minLength characters';
    }

    if (value.length > maxLength) {
      return 'Username must not exceed $maxLength characters';
    }

    // Build pattern based on allowed characters
    String pattern = r'^[a-zA-Z0-9';
    if (allowUnderscore) pattern += r'_';
    if (allowDot) pattern += r'\.';
    pattern += r']+$';

    final usernameRegex = RegExp(pattern);

    if (!usernameRegex.hasMatch(value)) {
      String allowed = 'letters and numbers';
      if (allowUnderscore && allowDot) {
        allowed += ', underscores, and dots';
      } else if (allowUnderscore) {
        allowed += ' and underscores';
      } else if (allowDot) {
        allowed += ' and dots';
      }
      return 'Username can only contain $allowed';
    }

    return null;
  }

  // ==================== UTILITY METHODS ====================

  /// Formats date for error messages
  static String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  /// Checks if a string is empty or null
  static bool isEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  /// Checks if a string is not empty
  static bool isNotEmpty(String? value) {
    return !isEmpty(value);
  }
}

// ==================== EXTENSION FOR EASY USAGE ====================

/// Extension methods for easier validation
extension StringValidationExtension on String? {
  bool get isValidEmail => AppValidator.validateEmail(this) == null;
  bool get isValidPhone =>
      AppValidator.validatePhone(this, isRequired: true) == null;
  bool get isValidUrl =>
      AppValidator.validateUrl(this, isRequired: true) == null;
  bool get isNotEmptyOrNull => AppValidator.isNotEmpty(this);
  bool get isEmptyOrNull => AppValidator.isEmpty(this);

  bool isValidPassword({
    int minLength = 8,
    bool requireUppercase = true,
    bool requireLowercase = true,
    bool requireNumbers = true,
    bool requireSpecialChars = true,
  }) {
    return AppValidator.validatePassword(
          this,
          minLength: minLength,
          requireUppercase: requireUppercase,
          requireLowercase: requireLowercase,
          requireNumbers: requireNumbers,
          requireSpecialChars: requireSpecialChars,
        ) ==
        null;
  }
}
