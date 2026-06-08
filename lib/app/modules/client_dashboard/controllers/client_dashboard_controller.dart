import 'package:get/get.dart';

class ClientDashboardController extends GetxController {
  final RxInt currentTab = 0.obs;

  void changeTab(int index) => currentTab.value = index;
}
