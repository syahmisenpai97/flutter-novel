import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const BackButtonWidget({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey.shade300,
            width: 2.0,
          ),
        ),
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
      onPressed: onPressed ?? () => Get.back(),
    );
  }
}
