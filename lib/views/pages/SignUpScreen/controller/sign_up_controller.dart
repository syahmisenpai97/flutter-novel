import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kacs/constants/enum.dart';
import 'package:kacs/services/api_services.dart';
import 'package:kacs/utils/utils.dart';

class SignUpController extends GetxController {
  final _api = ApiService();

  var selectedGender = ''.obs;
  var country = ''.obs;
  var countryCode = ''.obs;

  final firstNameController = TextEditingController().obs;
  final lastNameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final passwordController = TextEditingController().obs;
  final confirmPasswdController = TextEditingController().obs;
  final phoneNoController = TextEditingController().obs;

  final firstNameFocusNode = FocusNode().obs;
  final lastNameFocusNode = FocusNode().obs;
  final emailFocusNode = FocusNode().obs;
  final passwordFocusNode = FocusNode().obs;
  final confirmPasswdFocusNode = FocusNode().obs;
  final phoneNoFocusNode = FocusNode().obs;

  final rxRequestStatus = Status.COMPLETED.obs;
  RxString error = ''.obs;

  void setRxRequestStatus(Status _value) => rxRequestStatus.value = _value;

  void registerApi() {
    setRxRequestStatus(Status.LOADING);
    Map data = {
      "email": emailController.value.text,
      "firstName": firstNameController.value.text,
      "lastName": lastNameController.value.text,
      "gender": selectedGender.value,
      "countryCode": country.value,
      "phoneNumber": countryCode.value + phoneNoController.value.text,
      // "password": passwordController.value.text,
    };
    _api.registerApi(data).then((response) {
      setRxRequestStatus(Status.COMPLETED);

      if (response != null) {
        Get.toNamed('/otp', arguments: {"userDetails": response});
      }
    });
  }

  void updateSelectedGender(String newValue) {
    selectedGender.value = newValue;
  }

  void updateCountryCode(String? newValue) {
    if (newValue != null) {
      countryCode.value = newValue;
    }
  }

  void updateCountry(String? newValue) {
    if (newValue != null) {
      country.value = newValue;
    }
  }
}
