import 'package:get/get.dart';

class ClientProfileController extends GetxController {
  final user = <String, String>{
    'firstName': 'Anik',
    'lastName': '',
    'email': 'client@app.com',
    'phone': 'Not provided',
  }.obs;

  String get initials => (user['firstName']?.isNotEmpty == true)
      ? user['firstName']![0].toUpperCase()
      : 'U';

  String get fullName => '${user['firstName']} ${user['lastName']}'.trim();
}
