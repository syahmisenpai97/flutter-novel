import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kacs/views/style/model_style.dart';
import 'package:kacs/views/themes/theme_config.dart';
import 'package:kacs/views/widgets/form/phonenumber/country_code.dart';

class QPhoneNumber extends StatefulWidget {
  const QPhoneNumber({
    super.key,
    required this.validator,
    this.focusNode,
    required this.label,
    this.prefixIcon,
    this.hint,
    this.helper,
    this.controller,
    this.value,
    this.keyboardType,
    required this.onChangedCountry,
    this.onChanged,
    this.onFieldSubmitted,
    this.onInit,
    this.textInputAction,
  });

  final String label;
  final String? hint;
  final String? helper;
  final Widget? prefixIcon;
  final String? value;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Function(CountryCode)? onChangedCountry;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function(CountryCode?)? onInit;
  final TextInputAction? textInputAction;

  @override
  State<QPhoneNumber> createState() => _QPhoneNumberState();
}

class _QPhoneNumberState extends State<QPhoneNumber> {
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();
    textEditingController = widget.controller ?? TextEditingController();
    textEditingController.text = widget.value ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      child: TextFormField(
        enabled: true,
        controller: textEditingController,
        focusNode: widget.focusNode,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          labelText: widget.label,
          prefixIcon: Padding(
            padding: textFieldLPadding.copyWith(left: 10.sp, right: 5.sp),
            child: QCountryCode(
              onChanged: widget.onChangedCountry,
              onInit: widget.onInit,
            ),
          ),
          helperText: widget.helper,
          hintText: widget.hint,
          border: ModelStyle.defaultBorderTextField,
          focusedBorder: ModelStyle.focusedBorderTextField,
          labelStyle: ModelStyle.labelStyleTextField,
          contentPadding: const EdgeInsets.fromLTRB(20, 24, 0, 24),
        ),
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
      ),
    );
  }
}
