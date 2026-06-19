import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talktomylawyer/app/models/lawyers_models/lawyer_user_model.dart';
import 'package:talktomylawyer/app/repository/lawyer-auth-repository.dart';

class LawyerProfileController extends GetxController {
  final LawyerModel lawyerModel =
      LawyerAuthRepository.instance.getLawyerData() ?? LawyerModel();

  late final TextEditingController nameController;
  late final TextEditingController rateController;
  late final TextEditingController bioController;

  final List<String> allAreas = const [
    'criminal_law',
    'family_law',
    'corporate_law',
    'civil_law',
    'property_law',
    'labour_law',
  ];

  final RxList<String> selectedAreas = <String>['criminal_law', 'corporate_law'].obs;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController(text: lawyerModel.name ?? 'Rahman Khan');
    rateController = TextEditingController(text: '2500');
    bioController = TextEditingController(
      text: 'Experienced corporate and criminal lawyer with ${lawyerModel.numberOfExperience ?? '12'}+ years of practice.',
    );
  }

  void toggleArea(String area) {
    if (selectedAreas.contains(area)) {
      selectedAreas.remove(area);
    } else {
      selectedAreas.add(area);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    rateController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
