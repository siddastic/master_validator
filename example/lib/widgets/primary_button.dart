import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final Widget? child;
  final VoidCallback? onclick;
  const PrimaryButton(
      {required this.label, this.child, this.onclick, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onclick,
      child: child ??
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
    );
  }
}
