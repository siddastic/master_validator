import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  final String? Function(String? value)? validator;
  final TextEditingController? controller;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? prefix;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool isSafeInput;
  final bool? autofocus;
  final Function(String)? onChange;
  const Input({
    this.validator,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.prefix,
    this.maxLength,
    this.keyboardType,
    this.isSafeInput = false,
    this.autofocus,
    this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isSafeInput,
      onChanged: onChange,
      maxLength: maxLength,
      maxLengthEnforcement: maxLength != null
          ? MaxLengthEnforcement.enforced
          : MaxLengthEnforcement.none,
      autofocus: autofocus ?? false,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.black.withOpacity(.5),
              )
            : null,
        prefix: prefix,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(.5),
            width: .5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.black.withOpacity(.5),
            width: .5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.black,
            width: .75,
          ),
        ),
      ),
    );
  }
}
