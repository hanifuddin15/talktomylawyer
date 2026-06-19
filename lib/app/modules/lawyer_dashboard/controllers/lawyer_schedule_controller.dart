import 'package:get/get.dart';

class LawyerScheduleController extends GetxController {
  final List<String> days = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final RxList<int> selectedDays = <int>[0, 1, 2, 3, 4].obs; // Mon-Fri

  final List<String> timeSlots = const [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];
  final RxList<int> selectedSlots = <int>[0, 1, 4, 5].obs;

  final RxInt selectedCalDay = 9.obs;

  void toggleDay(int index) {
    if (selectedDays.contains(index)) {
      selectedDays.remove(index);
    } else {
      selectedDays.add(index);
    }
  }

  void toggleSlot(int index) {
    if (selectedSlots.contains(index)) {
      selectedSlots.remove(index);
    } else {
      selectedSlots.add(index);
    }
  }
}
