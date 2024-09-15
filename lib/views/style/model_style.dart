import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  static TextStyle get defaultTextButtonStyle {
    return GoogleFonts.montserrat(
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}
