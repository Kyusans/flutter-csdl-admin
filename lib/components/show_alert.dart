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
        snackPosition: SnackPosition.TOP,
        duration: const Duration(milliseconds: 1300),
      );
    } else if (variant.toLowerCase() == "info") {
      Get.snackbar(
        "Notice",
        message,
        colorText: Colors.white,
        backgroundColor: Colors.blue,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(milliseconds: 1300),
      );
    } else {
      Get.snackbar(
        "Error",
        message,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(milliseconds: 1300),
      );
    }
  }
}
