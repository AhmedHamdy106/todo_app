import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CustemTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  const CustemTextFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: TextFormField(
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          label: Text(label),
          hintText: hint,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.lightPrimary,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
