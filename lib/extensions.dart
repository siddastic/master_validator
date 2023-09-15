import 'package:master_validator/validators.dart';

extension ValidStringExt on String {
  bool get isEmail {
    return Validators.Required(next: Validators.Email())!(this) == null;
  }

  bool get isInteger {
    return Validators.Required(
            next: Validators.Number(
                integerOnly: true, allowDecimal: false))!(this) ==
        null;
  }

  bool get isDouble {
    return Validators.Required(
            next: Validators.Number(
                integerOnly: false, allowDecimal: true))!(this) ==
        null;
  }

  bool hasLengthBetween(int min, int max) {
    return Validators.LengthBetween(min, max)!(this) == null;
  }

  bool get isValidDirectoryName {
    return Validators.Required(next: Validators.DirectoryName())!(this) == null;
  }

  bool get isValidURL {
    return Validators.Required(next: Validators.Url())!(this) == null;
  }
}
