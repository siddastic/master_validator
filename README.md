# master_validator

A simple and quick form validation library for Flutter.

## Getting Started

### Installation

Add `master_validator` as dependency to your flutter project by adding this lines to `pubspec.yaml`.

```yaml
dependencies:
  master_validator: ">=0.0.1"
```

Then run `flutter pub get` to install required dependencies.

<small>Check [installation](https://pub.dev/packages/master_validator#-installing-tab-) tab for more information</small>


### Code

Import `master_validator` package to your dart widgets by writing:

```dart
import 'package:master_validator/master_validator.dart';
```

This makes the `MasterValidator` class available in your codespace


### Basic Required Field Validation

```dart
TextFormField(
    validator: MasterValidator.attach(
        flags: [ValidatorFlags.Required]
    ),
),
```

### Email Validation
```dart
TextFormField(
    validator: MasterValidator.attach(
        flags: [ValidatorFlags.Required, ValidatorFlags.Email],
        msgPrefix: "Email",
    ),
),
```

Note : By Default all validator flags support non required field, which means that if the field has an email validator flag but doesn't have the required flag with it, it wouldn't give an error message if the textfield is empty, to change this behaviour, use `MasterValidator.requiredAnd`, for Example

```dart
TextFormField(
    validator: MasterValidator.requiredAnd(
        flag: ValidatorFlags.Email,
        msgPrefix: "Email",
    ),
),
```


For detailed usage, check [example/lib](https://pub.dev/packages/master_validator/example)