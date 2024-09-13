import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class QCountryCode extends StatelessWidget {
  const QCountryCode({super.key, required this.onChanged, this.onInit});

  final Function(CountryCode)? onChanged;
  final Function(CountryCode?)? onInit;
  @override
  Widget build(BuildContext context) {
    return CountryCodePicker(
      onChanged: onChanged,
      onInit: onInit,
      initialSelection: 'MY',
      showCountryOnly: false,
      showOnlyCountryWhenClosed: false,
      alignLeft: false,
    );
  }
}
