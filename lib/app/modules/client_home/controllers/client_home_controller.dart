import 'package:get/get.dart';

class ClientHomeController extends GetxController {
  final categories = [
    {
      'icon': 'assets/icons/civil_law.svg',
      'name': 'Civil Law',
    }, // TODO: Replace with real assets or IconData for now
    {'icon': 'assets/icons/corporate_law.svg', 'name': 'Corporate Law'},
    {'icon': 'assets/icons/criminal_law.svg', 'name': 'Criminal Law'},
    {'icon': 'assets/icons/environmental_law.svg', 'name': 'Environmental Law'},
    {'icon': 'assets/icons/family_law.svg', 'name': 'Family Law'},
    {'icon': 'assets/icons/immigration_law.svg', 'name': 'Immigration Law'},
    {
      'icon': 'assets/icons/intellectual_property.svg',
      'name': 'Intellectual Property',
    },
    {'icon': 'assets/icons/labor_law.svg', 'name': 'Labor Law'},
    {'icon': 'assets/icons/property_law.svg', 'name': 'Property Law'},
    {'icon': 'assets/icons/tax_law.svg', 'name': 'Tax Law'},
  ];
}
