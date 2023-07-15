import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:master_validator/master_validator.dart';
import 'package:master_validator_example/widgets/primary_button.dart';

import 'widgets/input.dart';
import 'widgets/space.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xff262626),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Color(0xff262626),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.white,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff262b40),
            foregroundColor: const Color(0xff181b28),
          ),
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const FormValidationExample(),
    );
  }
}

enum SnackbarMessageType { Success, Error }

class FormValidationExample extends StatefulWidget {
  const FormValidationExample({super.key});

  @override
  State<FormValidationExample> createState() => _FormValidationExampleState();
}

class _FormValidationExampleState extends State<FormValidationExample> {
  final _formKey = GlobalKey<FormState>();

  void showSnackbar(String message, SnackbarMessageType type) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        backgroundColor:
            type == SnackbarMessageType.Success ? Colors.green : Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Master Validator Example'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          const Space(20),
          const Text("Validators.Email (Required)"),
          Space.def,
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Input(
                  validator: Validators.Required(next: Validators.Email()),
                  prefixIcon: Icons.alternate_email_rounded,
                  hintText: "Email",
                ),
                const Space(20),
                const Text("Validators.Number (Optional)"),
                Space.def,
                Input(
                  validator: Validators.Number(),
                  prefixIcon: Icons.numbers,
                  hintText: "Phone Number",
                ),
                const Space(20),
                const Text(
                    "Validators.Minlength + Validators.Maxlength (Required)"),
                Space.def,
                Input(
                  validator: Validators.Required(
                    errorMessage: "Username cannot be empty",
                    next: Validators.MinLength(
                      errorMessage: "Username must be at least 3 characters",
                      length: 3,
                      next: Validators.MaxLength(
                        length: 8,
                        errorMessage: "Username must be at most 8 characters",
                      ),
                    ),
                  ),
                  prefixIcon: Icons.person,
                  hintText: "Username",
                ),
                const Space(20),
                const Text("Validators.URL (Optional)"),
                Space.def,
                Input(
                  validator: Validators.Url(),
                  prefixIcon: Icons.link,
                  hintText: "URL",
                ),
                const Space(20),
                const Text("Validators.Regex (Optional)"),
                Space.def,
                Input(
                  validator: Validators.Regex(
                    pattern: r'^#?([0-9a-fA-F]{3}|[0-9a-fA-F]{6})$',
                    errorMessage: "Invalid Hex Color Code",
                  ),
                  prefixIcon: Icons.link,
                  hintText: "Hex Color Code ex - #000000",
                ),
              ],
            ),
          ),
          Space.def,
          PrimaryButton(
            label: "Validate",
            onclick: () {
              // validate form
              if (_formKey.currentState!.validate()) {
                showSnackbar("Form is valid", SnackbarMessageType.Success);
              } else {
                showSnackbar("Form is invalid", SnackbarMessageType.Error);
              }
            },
          ),
        ],
      ),
    );
  }
}
