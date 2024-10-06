import 'package:flutter/material.dart';

import '../utils/input_decoration.dart';

class UnderlineDropdownButton<T> extends StatelessWidget {
  const UnderlineDropdownButton({
    super.key,
    this.selectedValue,
    required this.items,
    this.hint = '',
    required this.onChanged,
  });

  final T? selectedValue;
  final List<T> items;
  final String hint;
  final Function(T?) onChanged;

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: underlineInputDecoration(context, hint).copyWith(
        contentPadding: const EdgeInsets.all(0.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          hint: Text(
            hint,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                ),
          ),
          value: selectedValue,
          items: items.map((value) {
            return DropdownMenuItem<T>(
              value: value,
              child: Text(value.toString(),
                  style: Theme.of(context).textTheme.bodyMedium),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
