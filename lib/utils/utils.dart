import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kacs/main.dart';
import 'package:kacs/views/widgets/toast.dart';

class Utils {
  static void fieldFocusNodeChange(BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static void showToast(String message, {bool isError = false}) {
    FToast fToast = FToast();
    fToast.init(navigatorKey.currentContext!);

    Widget toast = QToast(
      message: message,
      isError: isError,
    );

    FocusManager.instance.primaryFocus?.unfocus();

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 3),
    );
  }

  static snackBar(String title, String message, Color backgroundColor, Color colorText) {
    Get.snackbar(title, message, backgroundColor: backgroundColor, colorText: colorText);
  }
}
