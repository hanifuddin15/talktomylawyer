import 'package:get/get.dart';

class LawyerDashboardController extends GetxController {
  final RxInt currentTab = 0.obs;

  void changeTab(int index) => currentTab.value = index;
}
