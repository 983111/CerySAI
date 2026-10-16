import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label, hint;
  final IconData icon;
  final bool obscure;
  final TextInputType? keyboardType;
  final TextInputAction? action;
  final String? Function(String?)? validator;
  final Widget? suffix;
  final String? suffixText;
  final List<TextInputFormatter>? formatters;
  final TextCapitalization capitalization;
  final Iterable<String>? autofill;

  const AppTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.obscure = false,
    this.keyboardType,
    this.action = TextInputAction.next,
    this.validator,
    this.suffix,
    this.suffixText,
    this.formatters,
    this.capitalization = TextCapitalization.none,
    this.autofill,
  });

  OutlineInputBorder _b(Color c) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: c),
      );

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: C.text)),
      const SizedBox(height: 6),
      TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: keyboardType,
        textInputAction: action,
        validator: validator,
        inputFormatters: formatters,
        textCapitalization: capitalization,
        autofillHints: autofill,
        style: const TextStyle(fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 13, color: C.sub),
          prefixIcon: Icon(icon, size: 20, color: C.sub),
          suffixIcon: suffix,
          suffixText: suffixText,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 14),
          enabledBorder: _b(C.line),
          focusedBorder: _b(C.green),
          errorBorder: _b(C.red),
          focusedErrorBorder: _b(C.red),
        ),
      ),
    ]);
  }
}
