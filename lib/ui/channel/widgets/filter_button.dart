import 'package:flutter/material.dart';

import '../../../common/enums.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({
    super.key,
    required this.filter,
    required this.value,
    required this.isSelected,
    this.onPressed,
  });

  final SearchThreadFilter filter;
  final String value;
  final bool isSelected;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Chip(
        label: Text(value),
        backgroundColor:
            isSelected ? Theme.of(context).colorScheme.primary : null,
        labelStyle: isSelected
            ? Theme.of(context).primaryTextTheme.titleSmall
            : Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}
