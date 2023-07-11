enum ValidatorFlags {
  Required,
  Email,
}

class MasterValidator {
  static isValueEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  static String? Function(String? value)? attach({
    List<ValidatorFlags>? flags,
    String msgPrefix = 'Field',
    String? Function(String value)? customValidation,
  }) {
    if (flags == null || flags.isEmpty) {
      return null;
    }

    return (value) {
      if (flags.contains(ValidatorFlags.Required) &&
          (value == null || value.trim().isEmpty)) {
        return '$msgPrefix is required';
      }

      if (flags.contains(ValidatorFlags.Email)) {
        if (!isValueEmpty(value) &&
            !MasterValidatorHelpers.checkEmail(value!)) {
          return 'Invalid email';
        }
      }

      if (customValidation != null) {
        return customValidation(value!);
      }

      return null;
    };
  }

  static String? Function(String? value)? requiredAnd({
    ValidatorFlags? flag,
    String msgPrefix = 'Field',
    String? Function(String value)? customValidation,
  }) {
    if (flag == null) {
      return null;
    }

    return attach(
      flags: [ValidatorFlags.Required, flag],
      msgPrefix: msgPrefix,
      customValidation: customValidation,
    );
  }
}

class MasterValidatorHelpers {
  static bool checkEmail(String value) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
  }
}
