import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talktomylawyer/app/models/lawyers_models/law_categories_model.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';
import 'package:talktomylawyer/app/repository/lawyer-auth-repository.dart';
import 'package:talktomylawyer/app/repository/lawyer_dashboard_repository.dart';

class LawyerRegisterController extends GetxController {
  final RxInt step = 0.obs; // 0=Profile, 1=Expertise, 2=Documents, 3=Verify
  final RxBool isLoading = false.obs;

  // Step 1 Controllers
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  // Step 2 Controllers
  final barNumberController = TextEditingController();
  final yearsOfExpController = TextEditingController();
  final educationController = TextEditingController();

  String get fullName => fullNameController.text;
  set fullName(String val) => fullNameController.text = val;

  String get email => emailController.text;
  set email(String val) => emailController.text = val;

  String get phone => phoneController.text;
  set phone(String val) => phoneController.text = val;

  String get password => passwordController.text;
  set password(String val) => passwordController.text = val;

  String get barNumber => barNumberController.text;
  set barNumber(String val) => barNumberController.text = val;

  String get yearsOfExp => yearsOfExpController.text;
  set yearsOfExp(String val) => yearsOfExpController.text = val;

  String get education => educationController.text;
  set education(String val) => educationController.text = val;

  // Step 2 Categories
  final RxList<CategoryModel> categoriesList = <CategoryModel>[].obs;
  final RxBool isCategoriesLoading = false.obs;
  final RxList<int> selectedCategoryIds = <int>[].obs;

  // Step 3 — file paths (UI only)
  final RxString barLicensePath = ''.obs;
  final RxString nidPath = ''.obs;
  final RxString photoPath = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    barNumberController.dispose();
    yearsOfExpController.dispose();
    educationController.dispose();
    super.onClose();
  }

  Future<void> fetchCategories() async {
    isCategoriesLoading.value = true;
    try {
      final list = await LawyerDashboardRepository.instance.getCategories();
      categoriesList.assignAll(list);
    } catch (e) {
      // Handled
    } finally {
      isCategoriesLoading.value = false;
    }
  }

  void toggleCategory(int categoryId) {
    if (selectedCategoryIds.contains(categoryId)) {
      selectedCategoryIds.remove(categoryId);
    } else {
      selectedCategoryIds.add(categoryId);
    }
  }

  void nextStep() {
    if (step.value < 3) {
      step.value++;
    } else {
      _submit();
    }
  }

  void prevStep() {
    if (step.value > 0) step.value--;
  }

  Future<void> _submit() async {
    isLoading.value = true;
    try {
      // Create dummy files for the mock UI uploads if none selected
      final tempDir = Directory.systemTemp;

      final bool profilePicExists =
          photoPath.value.isNotEmpty && await File(photoPath.value).exists();
      final profilePicFile = profilePicExists
          ? File(photoPath.value)
          : File('${tempDir.path}/dummy_profile.jpg');
      if (!profilePicExists && !await profilePicFile.exists()) {
        await profilePicFile.writeAsString('dummy_profile_pic');
      }

      final bool licenseExists =
          barLicensePath.value.isNotEmpty &&
          await File(barLicensePath.value).exists();
      final licenseFile = licenseExists
          ? File(barLicensePath.value)
          : File('${tempDir.path}/dummy_license.pdf');
      if (!licenseExists && !await licenseFile.exists()) {
        await licenseFile.writeAsString('dummy_license_pdf');
      }

      final bool nidExists =
          nidPath.value.isNotEmpty && await File(nidPath.value).exists();
      final nidFile = nidExists
          ? File(nidPath.value)
          : File('${tempDir.path}/dummy_nid.pdf');
      if (!nidExists && !await nidFile.exists()) {
        await nidFile.writeAsString('dummy_nid_pdf');
      }

      // Map selectedCategoryIds to specialization list
      final List<int> specIds = selectedCategoryIds.isEmpty
          ? [1]
          : selectedCategoryIds.toList();

      final success = await LawyerAuthRepository.instance.registerLawyer(
        name: fullName,
        email: email,
        phone: phone,
        password: password,
        experience: yearsOfExp.isEmpty ? '1' : yearsOfExp,
        education: education.isEmpty ? 'LL.B' : education,
        barNumber: barNumber.isEmpty ? 'BC-00000' : barNumber,
        specializations: specIds,
        profilePic: profilePicFile,
        licence: licenseFile,
        nid: nidFile,
      );

      if (success) {
        final lawyer = await LawyerAuthRepository.instance.loginLawyer(
          email: email,
          password: password,
        );
        if (lawyer != null) {
          Get.offAllNamed(Routes.lawyerDashboard);
        } else {
          Get.offAllNamed(Routes.lawyerLogin);
        }
      }
    } catch (e) {
      // Error handling is managed by ApiCommunication
    } finally {
      isLoading.value = false;
    }
  }
}
