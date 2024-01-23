import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../authentication_repository/authentication_repository.dart';


class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  /// TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();

  // New boolean variable to track password visibility
  final RxBool showPassword = true.obs;

  // Add loginFormKey here
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }

  /// TextField Validation

  //Call this Function from Design & it will do the rest
  Future<void> login() async {
    String? error = await AuthenticationRepository.instance.loginInWithEmailAndPassword(email.text.trim(), password.text.trim());
    if(error != null) {
      Get.showSnackbar(GetSnackBar(message: error.toString(),));
    }

  }
}