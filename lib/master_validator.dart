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

  /// Returns a validator that checks if a string is a valid email.
  ///
  /// ### Arguments :
  /// - `errorMessage` : The error message to return if the string is not a valid email.
  /// - `next` : A validator to run after this validator.
  ///
  /// ### Usage :
  ///
  /// ```dart
  /// TextFormField(
  /// validator: Validators.Email(),
  /// ),
  /// ```
  ///
  /// ### Usage without TextFormField :
  ///
  /// ```dart
  /// final validator = Validators.Email();
  ///
  /// validator('hello'); // 'Invalid email'
  /// ```
  ///
  /// You can also chain validators like this:
  ///
  /// ```dart
  /// final validator = Validators.Required(
  /// next: Validators.Email(),
  /// );
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

  /// Returns a validator that checks if a string is a valid number.
  ///
  /// ### Arguments :
  /// - `errorMessage` : The error message to return if the string is not a valid number.
  /// - `next` : A validator to run after this validator.
  /// - `integerOnly` : If set to true, the validator will only accept integers.
  ///
  /// ### Usage :
  ///
  /// ```dart
  /// TextFormField(
  /// validator: Validators.Number(),
  /// ),
  /// ```
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

  /// Returns a validator that checks if a string's length lies between the values provided
  ///
  /// ### Arguments :
  /// - `min` : The minimum length of the string.
  /// - `max` : The maximum length of the string.
  /// - `errorMessage` : The error message to return if the string is not at least a certain length.
  /// - `next` : A validator to run after this validator.
  ///
  /// ### Usage :
  ///
  /// ```dart
  /// TextFormField(
  /// validator: Validators.LengthBetween(3,11),
  /// ),
  /// ```
  static String? Function(String? value)? LengthBetween(
    int min,
    int max, {
    String errorMessage =
        'Field Should be atleast *min_len* and at most *max_len* characters long',
    String? Function(String value)? next,
  }) {
    assert(min <= max, 'min cannot be greater than max');
    if (errorMessage.contains('*min_len*')) {
      errorMessage = errorMessage.replaceAll('*min_len*', min.toString());
    }
    if (errorMessage.contains('*max_len*')) {
      errorMessage = errorMessage.replaceAll('*max_len*', max.toString());
    }
    return (value) {
      if (value == null || value.trim().isEmpty) {
        return null;
      }

      if (value.length < min) {
        return errorMessage;
      }

      if (value.length > max) {
        return errorMessage;
      }

      if (next != null) {
        return next(value);
      }

      return null;
    };
  }

  /// Returns a validator that checks if a string is at least a certain length.
  ///
  /// ### Arguments :
  /// - `length` : The minimum length of the string.
  /// - `errorMessage` : The error message to return if the string is not at least a certain length.
  /// - `next` : A validator to run after this validator.
  ///
  /// ### Usage :
  ///
  /// ```dart
  /// TextFormField(
  /// validator: Validators.MinLength(length: 5),
  /// ),
  /// ```
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

  /// Returns a validator that checks if a string is at most a certain length.
  ///
  /// ### Arguments :
  /// - `length` : The maximum length of the string.
  /// - `errorMessage` : The error message to return if the string is not at most a certain length.
  /// - `next` : A validator to run after this validator.
  ///
  /// ### Usage :
  ///
  /// ```dart
  /// TextFormField(
  /// validator: Validators.MaxLength(length: 5),
  /// ),
  /// ```
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

  /// Returns a validator that checks if a string is a valid url.
  ///
  /// ### Arguments :
  /// - `errorMessage` : The error message to return if the string is not a valid url.
  /// - `next` : A validator to run after this validator.
  ///
  /// ### Usage :
  ///
  /// ```dart
  /// TextFormField(
  /// validator: Validators.Url(),
  /// ),
  /// ```
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

  /// Returns a validator that checks if a string is matches given regex pattern.
  ///
  /// ### Arguments :
  /// - `pattern` : The regex pattern to match.
  /// - `errorMessage` : The error message to return if the string does not match the pattern.
  /// - `next` : A validator to run after this validator.
  ///
  /// ### Usage :
  ///
  /// ```dart
  /// TextFormField(
  /// validator: Validators.Regex(pattern: r'^[a-zA-Z]+$'),
  /// ),
  /// ```
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

  /// Returns a validator that checks if a string equals to given string.
  ///
  /// ### Arguments :
  /// - `value` : The value to match
  /// - `errorMessage` : The error message to return if the string does not match the pattern.
  /// - `next` : A validator to run after this validator.
  ///
  /// ### Usage :
  ///
  /// ```dart
  /// TextFormField(
  /// validator: Validators.Equals(value : 'previous_password'),
  /// ),
  /// ```
  static String? Function(String? value)? Equals({
    required String value,
    String errorMessage = 'Value matches to the given value',
    String? Function(String value)? next,
  }) {
    return (v) {
      if (v == null || v.trim().isEmpty) {
        return null;
      }

      if (v == value) {
        return errorMessage;
      }

      if (next != null) {
        return next(v);
      }

      return null;
    };
  }
}
