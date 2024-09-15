import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kacs/constants/image_asset.dart';
import 'package:kacs/models/view_model_user.dart';
import 'package:kacs/views/pages/HomeScreen/home_screen.dart';
import 'package:kacs/views/widgets/apperances/bezierContainer.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(top: -MediaQuery.of(context).size.height * .15, right: -MediaQuery.of(context).size.width * .4, child: BezierContainer()),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Image(image: AssetImage(ImageAsset.avatarFemale)),
              const Column(
                children: [Text('data'), Text('data')],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: MaterialButton(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      color: const Color(0xFF1E232C),
                      shape: const RoundedRectangleBorder(
                          // borderRadius: BorderRadius.circular(8),
                          ),
                      onPressed: () {
                        Get.toNamed('/signIn');
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Expanded(
                    child: MaterialButton(
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xFF1E232C),
                        ),
                        // borderRadius: BorderRadius.circular(8),
                      ),
                      onPressed: () {
                        Get.toNamed('/signUp');
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          "Register",
                          style: TextStyle(
                            color: Color(0xFF1E232C),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
