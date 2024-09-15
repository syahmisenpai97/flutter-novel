import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kacs/constants/image_asset.dart';
import 'package:kacs/models/view_model_user.dart';

import 'package:kacs/views/style/model_style.dart';

import 'package:kacs/views/widgets/apperances/backgroundPainter.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final getBox = GetStorage();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userDataJson = getBox.read('userData');
      if (userDataJson != null) {
        final userData = ViewModelUser.fromJson(userDataJson);

        if (userData.isBlank == false) {
          Get.offAllNamed('/home');
        } else {}
      }
    });
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'My',
        style: GoogleFonts.majorMonoDisplay(
          textStyle: TextStyle(
            fontSize: 40.sp,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        children: [
          TextSpan(
            text: 'No',
            style: TextStyle(color: Colors.white, fontSize: 40.sp),
          ),
          TextSpan(
            text: 'vel',
            style: TextStyle(color: Colors.white, fontSize: 40.sp),
          ),
        ],
      ),
    );
  }

  Widget _subtitle() {
    return Text(
      'Read your favorite stories',
      textAlign: TextAlign.center,
      style: GoogleFonts.montserrat(
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: BackgroundPainter(),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              _title(),
              SizedBox(height: 60.h),
              Image.asset(
                ImageAsset.book,
                height: 200.h,
                width: 200.w,
                fit: BoxFit.cover,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: _subtitle(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: MaterialButton(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            color: const Color(0xFF1E232C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onPressed: () {
                              Get.toNamed('/signIn');
                            },
                            child: Text(
                              "Login",
                              style: ModelStyle.defaultTextButtonStyle,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: MaterialButton(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                color: Color(0xFF1E232C),
                              ),
                            ),
                            onPressed: () {
                              Get.toNamed('/signUp');
                            },
                            child: Text(
                              "Register",
                              style: ModelStyle.defaultTextButtonStyle.copyWith(
                                color: const Color(0xFF1E232C),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}
