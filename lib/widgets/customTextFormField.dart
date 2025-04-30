import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextCapitalization textCapitalization;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool enabled;
  final InputBorder? border;
  final TextStyle? textStyle;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final EdgeInsetsGeometry? contentPadding;
  final AutovalidateMode? autoValidateMode;
  const CustomTextFormField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.onChanged,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.enabled = true,
    this.border,
    this.textStyle,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.contentPadding,
    this.autoValidateMode,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        validator: validator,
        onChanged: onChanged,
        onTap: onTap,
        enabled: enabled,
        maxLines: maxLines,
        minLines: minLines,
        maxLength: maxLength,
        autovalidateMode: autoValidateMode,
        style: textStyle ?? const TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          border: border ?? const OutlineInputBorder(),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        ),
      ),
    );
  }
}