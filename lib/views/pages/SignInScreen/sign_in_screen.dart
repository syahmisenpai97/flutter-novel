import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kacs/constants/enum.dart';
import 'package:kacs/utils/validator/validator.dart';
import 'package:kacs/views/pages/SignInScreen/controller/sign_in_controller.dart';

import 'package:kacs/views/themes/theme_config.dart';
import 'package:kacs/views/widgets/form/button/button.dart';
import 'package:kacs/views/widgets/form/textfield/text_field.dart';

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
    return Scaffold(body: Obx(() {
      switch (signInController.rxRequestStatus.value) {
        case Status.LOADING:
          return const Center(
            child: CircularProgressIndicator(),
          );
        case Status.ERROR:
        case Status.COMPLETED:
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome\nto MagicBook",
                              style: TextStyle(
                                fontSize: 26.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Write less do more",
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Form(
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
                          QButton(
                            label: "Login",
                            onPressed: () async {
                              if (_signInForm.currentState!.validate()) {
                                await signInController.loginApi();
                              }
                            },
                          ),
                          const SizedBox(
                            height: 8.0,
                          ),
                          const Text(
                            "Forgot password?",
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                              ),
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
          );
      }
    }));
  }
}
