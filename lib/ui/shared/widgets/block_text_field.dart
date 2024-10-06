import 'package:flutter/material.dart';

class BlockTextField extends StatefulWidget {
  const BlockTextField({
    super.key,
    this.margin = const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
    this.backgroundColor,
    this.labelText,
    this.textStyle,
    this.prefixIcon,
  });

  final EdgeInsets margin;
  final Color? backgroundColor;
  final String? labelText;
  final TextStyle? textStyle;
  final Widget? prefixIcon;

  @override
  State<BlockTextField> createState() => _BlockTextFieldState();
}

class _BlockTextFieldState extends State<BlockTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: widget.margin,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(0.0),
        boxShadow: _isFocused
            ? <BoxShadow>[
                BoxShadow(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withOpacity(0.2), // Màu bóng
                  spreadRadius: 0.8,
                  blurRadius: 4,
                  offset: const Offset(4.0, 4.0), // Vị trí bóng
                ),
              ]
            : [
                BoxShadow(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                  spreadRadius: 0.5,
                  blurRadius: 0.1,
                  offset: const Offset(0.5, 0.5),
                ),
              ],
      ),
      child: TextFormField(
        focusNode: _focusNode,
        decoration: InputDecoration(
          filled: true,
          fillColor:
              widget.backgroundColor ?? Theme.of(context).colorScheme.surface,
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
            borderSide: BorderSide.none,
          ),
          labelText: widget.labelText ?? '',
          labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
          floatingLabelStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary.withOpacity(1.0),
              ),
          prefixIcon: widget.prefixIcon,
        ),
        style: widget.textStyle ?? Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
