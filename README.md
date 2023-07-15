# master_validator

[![Version](https://img.shields.io/pub/v/master_validator.svg)](https://pub.dev/packages/master_validator)
![GitHub](https://img.shields.io/github/license/siddastic/master_validator)
[![Netlify Status](https://api.netlify.com/api/v1/badges/ac15884c-8c64-43b7-b82c-4637db9498c2/deploy-status)](https://app.netlify.com/sites/master-validator/deploys)

### [Live Demo](https://master-validator.netlify.app/)

Simple and quick form validation library for Flutter.

* Easy to get started with
* Lightweight
* Customizable Error Messages
* Validator Chaining


![](https://i.ibb.co/Lzx2VSY/example.gif)

## Getting Started

### Installation

Add `master_validator` as dependency to your flutter project by running the following command in `project-root`.

```yaml
flutter pub add master_validator
```

Then run `flutter pub get` to install required dependencies.

<small>Check [installation](https://pub.dev/packages/master_validator#-installing-tab-) tab for more information</small>


### Code

Import `master_validator` package to your dart widgets by writing:

```dart
import 'package:master_validator/master_validator.dart';
```

This makes the `Validators` class available in your codespace


### Basic Required Field Validation

Use `Validators.Required()` to make a field required.

```dart
TextFormField(
    validator: Validators.Required(
        errorMessage : "This field cannot be left empty",
    )
),
```

### Email Validation
```dart
TextFormField(
    validator: Validators.Required(
        next : Validators.Email(),
    ),
),
```

### Inbuild Validation methods :

- Validators.Required()
- Validators.Email()
- Validators.Number()
- Validators.Minlength()
- Validators.Maxlength()
- Validators.Url()
- Validators.Regex()

Every validator has an `errorMessage` parameter to customize the error message and a `next` parameter to chain another validator

### Using Multiple Validators (Chaining Validators)

All validators take a `next` argument in which you can specify another validator (a custom function, or another predefined validator) like :

```dart
TextFormField(
    validator: Validators.Required(
        next : Validators.Email(
            next : Validators.Maxlength(50)
        ),
    ),
),
```

> **Note:** While Chaining, Order MATTERS!


> **NOTE:**  By default All Validators except `Validators.Required()` will not throw an error if the data is empty/null, this means if you defined a validator like :

```dart
TextFormField(
    validator: Validators.Email(),
),
```
> It means the field acts as an optional field but if something is entered it must qualify as an email, to change this behaviour, and to make the field required, use `Validators.Required()` before any other validator, for example -

```dart
TextFormField(
    validator: Validators.Required(
        next : Validators.Url(),
    ),
),
```


For detailed usage, check [example/lib](https://pub.dev/packages/master_validator/example)