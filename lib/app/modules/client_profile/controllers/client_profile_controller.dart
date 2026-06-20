import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talktomylawyer/app/models/client_models/client_user_model.dart';
import 'package:talktomylawyer/app/repository/client_auth_repository.dart';

class ClientProfileController extends GetxController {
  Rxn<ClientModel> get clientData => ClientAuthRepository.instance.clientData;
  final RxBool isEditing = false.obs;
  final RxBool isLoading = false.obs;

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController addressController;
  late final TextEditingController cityController;
  late final TextEditingController countryController;

  @override
  void onInit() {
    super.onInit();
    final client = clientData.value;

    nameController = TextEditingController(text: client?.name ?? '');
    phoneController = TextEditingController(text: client?.phone ?? '');
    addressController = TextEditingController(text: client?.address ?? '');
    cityController = TextEditingController(text: client?.city ?? '');
    countryController = TextEditingController(text: client?.country ?? '');
  }

  String get initials {
    final name = clientData.value?.name ?? 'User';
    if (name.isEmpty) return 'U';
    return name.trim().split(' ').map((e) => e.isNotEmpty ? e.substring(0, 1) : '').join().toUpperCase();
  }

  void toggleEdit() {
    isEditing.value = !isEditing.value;
    if (!isEditing.value) {
      // Reset values to cached version if cancelling
      final client = clientData.value;
      nameController.text = client?.name ?? '';
      phoneController.text = client?.phone ?? '';
      addressController.text = client?.address ?? '';
      cityController.text = client?.city ?? '';
      countryController.text = client?.country ?? '';
    }
  }

  Future<void> saveChanges() async {
    isLoading.value = true;
    try {
      final updated = await ClientAuthRepository.instance.updateClientProfile(
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        city: cityController.text.trim(),
        country: countryController.text.trim(),
      );

      if (updated != null) {
        clientData.value = updated;
        isEditing.value = false;
        // Optionally trigger profile tab refresh if they go back
      }
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    countryController.dispose();
    super.onClose();
  }
}
