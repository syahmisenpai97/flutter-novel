// custom_toast.dart
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QToast extends StatelessWidget {
  final String message;
  final bool isError;
  final FToast fToast = FToast();

  QToast({required this.message, this.isError = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: isError ? Colors.redAccent : Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isError ? Icon(Icons.info_outline) : Icon(Icons.check),
          SizedBox(width: 12.0),
          Text(message),
        ],
      ),
    );
  }
}