import 'package:flutter/material.dart';

class ModelStyle {
  static InputBorder get defaultBorderTextField {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: const BorderSide(
        color: Colors.black,
        width: 2,
      ),
    );
  }

  static InputBorder get focusedBorderTextField {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: const BorderSide(
        width: 2,
      ),
    );
  }

  static TextStyle get labelStyleTextField {
    return const TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      fontFamily: 'Montserrat',
    );
  }
}
