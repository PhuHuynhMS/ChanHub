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
      super.key});
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? maxLines;
  final String? labelText;
  final String? hintText;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      controller: controller,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        label:
            Text('$labelText', style: Theme.of(context).textTheme.titleMedium),
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.labelMedium,
      ),
      style: Theme.of(context).textTheme.bodyMedium,
      readOnly: readOnly,
    );
  }
}
