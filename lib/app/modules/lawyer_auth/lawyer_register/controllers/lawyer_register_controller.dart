import 'dart:io';
import 'package:get/get.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';
import 'package:talktomylawyer/app/repository/lawyer-auth-repository.dart';

class LawyerRegisterController extends GetxController {
  final RxInt step = 0.obs; // 0=Profile, 1=Expertise, 2=Documents, 3=Verify
  final RxBool isLoading = false.obs;

  // Step 1
  String fullName = '';
  String email = '';
  String phone = '';
  String password = '';

  // Step 2
  String barNumber = '';
  String yearsOfExp = '';
  String education = '';
  List<String> practiceAreas = [];

  // Step 3 — file paths (UI only)
  final RxString barLicensePath = ''.obs;
  final RxString nidPath = ''.obs;
  final RxString photoPath = ''.obs;

  final List<String> allPracticeAreas = [
    'criminal_law',
    'family_law',
    'corporate_law',
    'civil_law',
    'property_law',
    'labour_law',
    'immigration',
    'tax_law',
  ];

  void togglePracticeArea(String area) {
    if (practiceAreas.contains(area)) {
      practiceAreas.remove(area);
    } else {
      practiceAreas.add(area);
    }
    // trigger rebuild
    step.refresh();
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

      final profilePicFile = photoPath.value.isNotEmpty
          ? File(photoPath.value)
          : File('${tempDir.path}/dummy_profile.jpg');
      if (photoPath.value.isEmpty && !await profilePicFile.exists()) {
        await profilePicFile.writeAsString('dummy_profile_pic');
      }

      final licenseFile = barLicensePath.value.isNotEmpty
          ? File(barLicensePath.value)
          : File('${tempDir.path}/dummy_license.pdf');
      if (barLicensePath.value.isEmpty && !await licenseFile.exists()) {
        await licenseFile.writeAsString('dummy_license_pdf');
      }

      final nidFile = nidPath.value.isNotEmpty
          ? File(nidPath.value)
          : File('${tempDir.path}/dummy_nid.pdf');
      if (nidPath.value.isEmpty && !await nidFile.exists()) {
        await nidFile.writeAsString('dummy_nid_pdf');
      }

      // Map practiceAreas string to IDs
      final List<int> specIds = [];
      for (final area in practiceAreas) {
        final idx = allPracticeAreas.indexOf(area);
        if (idx != -1) {
          specIds.add(idx + 1); // 1-indexed IDs
        }
      }
      if (specIds.isEmpty) {
        specIds.add(
          1,
        ); // Default specialization if none selected to prevent API failure
      }

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
