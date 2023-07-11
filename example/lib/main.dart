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
  final _masterValidatorPlugin = MasterValidator();

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

class FormValidationExample extends StatefulWidget {
  const FormValidationExample({super.key});

  @override
  State<FormValidationExample> createState() => _FormValidationExampleState();
}

class _FormValidationExampleState extends State<FormValidationExample> {
  final _formKey = GlobalKey<FormState>();
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
          const Text("Email"),
          Space.def,
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Input(
                  validator: MasterValidator.requiredAnd(
                    flag: ValidatorFlags.Email,
                    msgPrefix: "Email",
                  ),
                  prefixIcon: Icons.alternate_email_rounded,
                  hintText: "Enter Email",
                ),
                const Space(20),
                const Text("Password"),
                Space.def,
                Input(
                  validator: MasterValidator.attach(
                    flags: [ValidatorFlags.Required],
                    msgPrefix: "Password",
                  ),
                  prefixIcon: Icons.key_rounded,
                  hintText: "Enter Password",
                  isSafeInput: true,
                ),
              ],
            ),
          ),
          Space.def,
          PrimaryButton(
            label: "Submit",
            onclick: () {
              // validate form
              if (_formKey.currentState!.validate()) {
                // do something
              }
            },
          ),
        ],
      ),
    );
  }
}
