import 'package:flutter/widgets.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late final TextEditingController userIdController;
  late final TextEditingController passwordController;
  Rx<bool> obscureText = true.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey();

  /*
   * ┏==================================================================================================┓
   * ┃                                         Life Cycle                                               ┃
   * ┗==================================================================================================┛
   */

  @override
  void onInit() {
    super.onInit();
    userIdController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    userIdController.dispose();
    passwordController.dispose();
  }

  RxBool isClient = true.obs;

  void toggleRole(bool client) {
    isClient.value = client;
  }

  /*
   * ┏==================================================================================================┓
   * ┃                                          User Events                                             ┃
   * ┗==================================================================================================┛
   */

  void onPressedLogin() {
    // For now, mock login
    if (isClient.value) {
      Get.offAllNamed(Routes.clientDashboard);
    } else {
      Get.snackbar('Coming Soon', 'Lawyer portal is under construction');
    }
  }

  void onPressedCreateAccount() {
    Get.snackbar('Coming Soon', 'Registration flow is under construction');
  }

  void onPressedChangePassword() {
    Get.snackbar('Coming Soon', 'Password reset flow is under construction');
  }

  /*
   * ┏==================================================================================================┓
   * ┃                                          Network Calls                                           ┃
   * ┗==================================================================================================┛
   */

  // Kept for future integration
  Future<void> loginUser({
    required String userId,
    required String password,
  }) async {
    // UserModel? userModel = await _repository.loginUser(
    //   userId: userId,
    //   password: password,
    // );
    // if (userModel.isNotNullOrEmpty) {
    //   Get.offAllNamed(Routes.home);
    // }
  }
}
