import 'package:flutter/material.dart';

class BlockTextField extends StatefulWidget {
  const BlockTextField({
    super.key,
    this.margin = const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
    this.controller,
    this.backgroundColor,
    this.labelText,
    this.textStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
    this.enabled = true,
    this.keyboardType,
    this.textInputAction,
    this.obscureText,
    this.enableSuggestions,
    this.autocorrect,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.maxLines,
  });

  final EdgeInsets margin;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final String? labelText;
  final TextStyle? textStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final bool enabled;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final bool? enableSuggestions;
  final bool? autocorrect;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final int? maxLines;

  @override
  State<BlockTextField> createState() => _BlockTextFieldState();
}

class _BlockTextFieldState extends State<BlockTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
        _error = _isFocused ? null : _error;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  String? _validate(String? value) {
    _error = widget.validator!(value);
    setState(() {});
    return _error;
  }

  @override
  Widget build(BuildContext context) {
    // Box shadow styles
    final List<BoxShadow> focusedActiveShadow = <BoxShadow>[
      BoxShadow(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
        spreadRadius: 0.8,
        blurRadius: 4,
        offset: const Offset(4.0, 4.0),
      ),
    ];

    final List<BoxShadow> focusedInactiveShadow = <BoxShadow>[
      BoxShadow(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
        spreadRadius: 0.5,
        blurRadius: 0.1,
        offset: const Offset(0.5, 0.5),
      ),
    ];

    final List<BoxShadow> inactiveShadow = <BoxShadow>[];

    return Column(
      children: <Widget>[
        AnimatedContainer(
          margin: widget.margin,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          width: double.infinity,
          decoration: BoxDecoration(
            color:
                widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(0.0),
            boxShadow: !widget.enabled
                ? inactiveShadow
                : _isFocused
                    ? focusedActiveShadow
                    : focusedInactiveShadow,
          ),
          child: TextFormField(
            controller: widget.controller,
            enabled: widget.enabled,
            keyboardType: widget.keyboardType ?? TextInputType.text,
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            validator: _validate,
            onSaved: widget.onSaved,
            onChanged: widget.onChanged,
            maxLines: widget.maxLines ?? 1,
            obscureText: widget.obscureText ?? false,
            enableSuggestions: widget.enableSuggestions ?? true,
            autocorrect: widget.autocorrect ?? true,
            focusNode: _focusNode,
            decoration: InputDecoration(
                filled: true,
                fillColor: widget.backgroundColor ??
                    Theme.of(context).colorScheme.surface,
                border: InputBorder.none,
                labelText: widget.labelText ?? '',
                labelStyle: Theme.of(context).textTheme.labelMedium,
                floatingLabelStyle: Theme.of(context).textTheme.titleMedium,
                hintStyle: Theme.of(context).textTheme.labelMedium,
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon,
                errorStyle: const TextStyle(height: 0.001, fontSize: 0.0)),
            style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
          ),
        ),

        // Error message
        if (_error != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _error!,
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
            ),
          ),
      ],
    );
  }
}
