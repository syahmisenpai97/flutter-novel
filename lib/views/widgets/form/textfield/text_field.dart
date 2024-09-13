import 'package:flutter/material.dart';
import 'package:kacs/views/style/model_style.dart';
import 'package:kacs/views/themes/theme_config.dart';

class QTextField extends StatefulWidget {
  const QTextField({
    required this.label,
    required this.onChanged,
    super.key,
    this.id,
    this.value,
    this.validator,
    this.hint,
    this.helper,
    this.maxLength,
    this.onSubmitted,
    this.obscure = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
    this.controller,
    this.keyboardType,
    this.textInputAction,
  });
  final String? id;
  final String label;
  final String? value;
  final String? hint;
  final String? helper;
  final String? Function(String?)? validator;
  final bool obscure;
  final bool enabled;
  final int? maxLength;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function(String) onChanged;
  final Function(String)? onSubmitted;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  @override
  State<QTextField> createState() => _QTextFieldState();
}

class _QTextFieldState extends State<QTextField> {
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  bool visible = false;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    textEditingController = widget.controller ?? TextEditingController();
    textEditingController.text = widget.value ?? '';
    super.initState();
  }

  String getValue() {
    return textEditingController.text;
  }

  setValue(value) {
    textEditingController.text = value;
  }

  resetValue() {
    textEditingController.text = '';
  }

  focus() {
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    Widget? prefix = widget.prefixIcon != null && widget.obscure
        ? InkWell(
            onTap: () {
              setState(() {
                visible = !visible;
              });
            },
            child: Padding(padding: textFieldLPadding, child: Icon(visible ? Icons.visibility : Icons.visibility_off)),
          )
        : widget.prefixIcon != null
            ? Padding(padding: textFieldLPadding, child: Icon(widget.prefixIcon))
            : null;

    Widget? suffix = widget.suffixIcon != null && widget.obscure
        ? InkWell(
            onTap: () {
              setState(() {
                visible = !visible;
              });
            },
            child: Padding(padding: textFieldRPadding, child: Icon(visible ? Icons.visibility : Icons.visibility_off)),
          )
        : widget.suffixIcon != null
            ? Padding(padding: textFieldRPadding, child: Icon(widget.suffixIcon))
            : null;

    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: TextFormField(
        enabled: widget.enabled,
        controller: textEditingController,
        focusNode: focusNode,
        validator: widget.validator,
        maxLength: widget.maxLength,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        obscureText: widget.obscure && !visible,
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: prefix,
          suffixIcon: suffix,
          helperText: widget.helper,
          hintText: widget.hint,
          border: ModelStyle.defaultBorderTextField,
          focusedBorder: ModelStyle.focusedBorderTextField,
          labelStyle: ModelStyle.labelStyleTextField,
          contentPadding: const EdgeInsets.fromLTRB(20, 24, 0, 24),
        ),
        onChanged: (value) {
          widget.onChanged(value);
        },
        onFieldSubmitted: (value) {
          if (widget.onSubmitted != null) widget.onSubmitted!(value);
        },
      ),
    );
  }
}
