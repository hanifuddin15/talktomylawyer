import 'package:get/get.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';

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
  String barLicensePath = '';
  String nidPath = '';
  String photoPath = '';

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
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
    Get.offAllNamed(Routes.lawyerDashboard);
  }
}
