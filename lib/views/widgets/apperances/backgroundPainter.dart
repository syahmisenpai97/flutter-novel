import 'package:flutter/material.dart';
import 'package:kacs/views/themes/theme_config.dart';

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw top shape (curved background)
    Paint paint = Paint()..color = topBackgroundColor;
    Path path = Path();

    path.moveTo(0, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.3, size.height * 0.4, size.width, size.height * 0.3);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);

    // Draw bottom shape (curved background)
    paint.color = focusedBorderColor;
    path = Path();

    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.3);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.6, size.width, size.height * 0.7);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
