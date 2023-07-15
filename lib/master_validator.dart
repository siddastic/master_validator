// ignore_for_file: non_constant_identifier_names

class MasterValidatorHelpers {
  static bool checkEmail(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
}

// Validators
class Validators {
  // dart documentation

  /// Returns a validator that checks if a string is empty.
  ///
  /// ### Arguments :
  /// - `errorMessage` : The error message to return if the string is empty.
  /// - `next` : A validator to run after this validator.
  ///
  /// ### Usage :
  ///
  /// ```dart
  /// TextFormField(
  ///  validator: Validators.Required(),
  /// ),
  ///  ```
  ///
  /// ### Usage without TextFormField :
  ///
  /// ```dart
  /// final validator = Validators.Required();
  ///
  /// validator(''); // 'Field cannot be empty'
  ///
  /// validator('   '); // 'Field cannot be empty'
  ///
  /// validator('hello'); // null
  ///
  /// ```
  ///
  /// You can also chain validators like this:
  ///
  /// ```dart
  /// final validator = Validators.Required(
  ///  next: Validators.Email(),
  /// );
  ///
  /// validator(''); // 'Field cannot be empty'
  ///
  /// validator('   '); // 'Field cannot be empty'
  ///
  /// validator('hello'); // 'Invalid email'
  ///
  /// ```
  static String? Function(String? value)? Required({
    String errorMessage = 'Field cannot be empty',
    String? Function(String value)? next,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return errorMessage;
      }

      if (next != null) {
        return next(value);
      }

      return null;
    };
  }

  static String? Function(String? value)? Email({
    String errorMessage = 'Invalid email',
    String? Function(String value)? next,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return null;
      }

      if (!MasterValidatorHelpers.checkEmail(value)) {
        return errorMessage;
      }

      if (next != null) {
        return next(value);
      }

      return null;
    };
  }

  static String? Function(String? value)? Number({
    String errorMessage = 'Invalid number',
    String? Function(String value)? next,
    bool integerOnly = false,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return null;
      }

      if (integerOnly) {
        if (int.tryParse(value) == null) {
          return errorMessage;
        }
      } else {
        if (num.tryParse(value) == null) {
          return errorMessage;
        }
      }

      if (next != null) {
        return next(value);
      }

      return null;
    };
  }

  static String? Function(String? value)? MinLength({
    required int length,
    String errorMessage = 'Minimum length is *min_len*',
    String? Function(String value)? next,
  }) {
    if (errorMessage.contains('*min_len*')) {
      errorMessage = errorMessage.replaceAll('*min_len*', length.toString());
    }
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return null;
      }

      if (value.length < length) {
        return errorMessage;
      }

      if (next != null) {
        return next(value);
      }

      return null;
    };
  }

  static String? Function(String? value)? MaxLength({
    required int length,
    String errorMessage = 'Maximum length is *max_len*',
    String? Function(String value)? next,
  }) {
    if (errorMessage.contains('*max_len*')) {
      errorMessage = errorMessage.replaceAll('*max_len*', length.toString());
    }
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return null;
      }

      if (value.length > length) {
        return errorMessage;
      }

      if (next != null) {
        return next(value);
      }

      return null;
    };
  }

  static String? Function(String? value)? Url({
    String errorMessage = 'Invalid url',
    String? Function(String value)? next,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return null;
      }

      if (!RegExp(
              r"^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}")
          .hasMatch(value)) {
        return errorMessage;
      }

      if (next != null) {
        return next(value);
      }

      return null;
    };
  }

  static String? Function(String? value)? Regex({
    required String pattern,
    String errorMessage = 'Invalid value',
    String? Function(String value)? next,
  }) {
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return null;
      }

      if (!RegExp(pattern).hasMatch(value)) {
        return errorMessage;
      }

      if (next != null) {
        return next(value);
      }

      return null;
    };
  }
}
