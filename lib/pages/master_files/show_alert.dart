import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ShowAlert {
  void showAlert(String variant, String message) {
    if (variant.toLowerCase() == "success") {
      Get.snackbar(
        "Success",
        message,
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        "Error",
        message,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
