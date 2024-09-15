import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kacs/utils/validator/validator.dart';
import 'package:kacs/views/pages/SignUpScreen/controller/sign_up_controller.dart';
import 'package:kacs/views/widgets/form/button/button.dart';
import 'package:kacs/views/widgets/form/dropdown/dropdown_field.dart';
import 'package:kacs/views/widgets/form/phonenumber/phone_number.dart';
import 'package:kacs/views/widgets/form/textfield/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final signUpController = Get.put(SignUpController());
  final _signUpForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Register",
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
              Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: _signUpForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        QTextField(
                          label: "First Name",
                          validator: Validator.required,
                          prefixIcon: Icons.abc,
                          keyboardType: TextInputType.name,
                          value: null,
                          controller: signUpController.firstNameController.value,
                          focusNode: signUpController.firstNameFocusNode.value,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {},
                        ),
                        QTextField(
                          label: "Last Name",
                          validator: Validator.required,
                          prefixIcon: Icons.abc,
                          keyboardType: TextInputType.name,
                          value: null,
                          controller: signUpController.lastNameController.value,
                          focusNode: signUpController.lastNameFocusNode.value,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {},
                        ),
                        QTextField(
                          label: "Email",
                          validator: Validator.email,
                          prefixIcon: Icons.email,
                          value: null,
                          controller: signUpController.emailController.value,
                          focusNode: signUpController.emailFocusNode.value,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {},
                        ),
                        QTextField(
                          label: "Password",
                          obscure: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: Validator.required,
                          suffixIcon: Icons.password,
                          prefixIcon: Icons.lock,
                          value: null,
                          controller: signUpController.passwordController.value,
                          focusNode: signUpController.passwordFocusNode.value,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {},
                        ),
                        QTextField(
                          label: "Confirm Password",
                          obscure: true,
                          validator: (value) => Validator.passwordMatch(signUpController.passwordController.value.text, value),
                          keyboardType: TextInputType.visiblePassword,
                          suffixIcon: Icons.password,
                          prefixIcon: Icons.lock,
                          value: null,
                          controller: signUpController.confirmPasswdController.value,
                          focusNode: signUpController.confirmPasswdFocusNode.value,
                          textInputAction: TextInputAction.next,
                          onChanged: (value) {},
                        ),
                        QDropdownField(
                          label: "Gender",
                          validator: Validator.required,
                          items: const [
                            {
                              "label": "Male",
                              "value": "Male",
                            },
                            {
                              "label": "Female",
                              "value": "Female",
                            }
                          ],
                          value: "-",
                          onChanged: (value, label) {
                            if (value != null) {
                              signUpController.updateSelectedGender(value);
                            }
                          },
                        ),
                        QPhoneNumber(
                          validator: Validator.required,
                          label: "Phone Number",
                          keyboardType: TextInputType.number,
                          controller: signUpController.phoneNoController.value,
                          focusNode: signUpController.phoneNoFocusNode.value,
                          textInputAction: TextInputAction.done,
                          onChangedCountry: (value) {
                            signUpController.updateCountryCode(value.dialCode);
                            signUpController.updateCountry(value.code);
                          },
                          onInit: (value) {
                            signUpController.updateCountryCode(value?.dialCode);
                            signUpController.updateCountry(value?.code);
                          },
                        ),
                        QButton(
                          label: "Register",
                          onPressed: () {
                            if (_signUpForm.currentState!.validate()) {
                              if (signUpController.passwordController.value.text == signUpController.confirmPasswdController.value.text) {
                                signUpController.registerApi();
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
