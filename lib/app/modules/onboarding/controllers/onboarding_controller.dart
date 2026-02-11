import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class OnboardingController extends GetxController {
  final PageController pageController = PageController();
  final RxInt currentIndex = 0.obs;

  void onPageChanged(int index) {
    currentIndex.value = index;
  }

  void next() {
    if (currentIndex.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.offAllNamed(Routes.roleSelection);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
