import 'package:flutter/material.dart';

class CustomizedTextField extends StatelessWidget {
  const CustomizedTextField(
      {this.onChanged,
      this.controller,
      this.validator,
      this.maxLength,
      this.maxLines = 1,
      this.labelText,
      this.hintText,
      this.readOnly = false,
      this.initialValue,
      super.key});

  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? maxLines;
  final String? labelText;
  final String? hintText;
  final bool readOnly;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      maxLength: maxLength,
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label: Text('$labelText'),
        hintText: hintText,
      ),
      style: Theme.of(context).textTheme.bodyMedium,
      readOnly: readOnly,
    );
  }
}
