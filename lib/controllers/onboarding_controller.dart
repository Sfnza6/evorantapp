// lib/controllers/onboarding_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  var currentPage = 0.obs;

  final onboardingPages = [
    {
      "image": "assets/images/evoronta_image_1.png",
      "title": "Nearby restaurants",
      "desc":
          "You don't have to go far to find a good restaurant,\nwe have provided all the restaurants that is near you"
    },
    {
      "image": "assets/images/evoronta_image_2.png",
      "title": "Fast delivery",
      "desc":
          "We ensure your order is delivered fast and hot,\nright to your doorstep."
    },
    {
      "image": "assets/images/evoronta_image_3.png",
      "title": "Easy Payment",
      "desc":
          "Multiple payment options with secure processing\nfor a smooth experience."
    },
  ];

  void nextPage() {
    if (currentPage.value < onboardingPages.length - 1) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    } else {
      Get.offAllNamed('/welcome'); // استبدل لاحقاً بالشاشة المطلوبة
    }
  }

  void skip() {
    Get.offAllNamed('/welcome'); // تخطي onboarding
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
