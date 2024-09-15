import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kacs/constants/enum.dart';
import 'package:kacs/utils/validator/validator.dart';
import 'package:kacs/views/pages/SignInScreen/controller/sign_in_controller.dart';
import 'package:kacs/views/style/model_style.dart';

import 'package:kacs/views/themes/theme_config.dart';
import 'package:kacs/views/widgets/apperances/bezierContainer.dart';
import 'package:kacs/views/widgets/form/button/button.dart';
import 'package:kacs/views/widgets/form/textfield/text_field.dart';
import 'package:kacs/views/widgets/loading/wave_spinner.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final signInController = Get.put(SignInController());
  final _signInForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Obx(() {
        switch (signInController.rxRequestStatus.value) {
          case Status.LOADING:
            return const Center(
              child: QLoadingSpinWave(),
            );
          case Status.ERROR:
          case Status.COMPLETED:
            return SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    top: -height * .15,
                    right: -MediaQuery.of(context).size.width * .4,
                    child: const BezierContainer(),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 50.h),
                                      child: Text(
                                        "Welcome\nto MyNovel",
                                        style: GoogleFonts.euphoriaScript(
                                          textStyle: TextStyle(
                                            fontSize: 40.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4.0,
                                    ),
                                    Text(
                                      "Bringing Stories to Life",
                                      style: GoogleFonts.lekton(
                                        textStyle: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20), // Add space before form
                          Form(
                            key: _signInForm,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                QTextField(
                                  label: "Email",
                                  validator: Validator.email,
                                  controller: signInController.emailController.value,
                                  focusNode: signInController.emailFocusNode.value,
                                  textInputAction: TextInputAction.next,
                                  prefixIcon: Icons.person,
                                  onChanged: (value) {},
                                ),
                                QTextField(
                                  label: "Password",
                                  obscure: true,
                                  validator: Validator.required,
                                  controller: signInController.passwordController.value,
                                  focusNode: signInController.passwordFocusNode.value,
                                  textInputAction: TextInputAction.next,
                                  prefixIcon: Icons.lock,
                                  suffixIcon: Icons.password,
                                  onChanged: (value) {},
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 20.w),
                                    child: const Text(
                                      "Forgot password?",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                QButton(
                                  label: "Login",
                                  style: ModelStyle.defaultTextButtonStyle,
                                  onPressed: () async {
                                    if (_signInForm.currentState!.validate()) {
                                      await signInController.loginApi();
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),

                          SizedBox(height: 170.h),
                          SizedBox(
                            height: 46,
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: disabledColor,
                              ),
                              onPressed: () {
                                Get.toNamed('/signUp');
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Sign Up",
                                      style: ModelStyle.defaultTextButtonStyle.copyWith(color: Colors.grey[900]),
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    size: 24.0,
                                    color: Colors.grey[900],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
        }
      }),
    );
  }
}
