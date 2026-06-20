import 'package:get/get.dart';
import 'package:talktomylawyer/app/models/client_models/client_user_model.dart';
import 'package:talktomylawyer/app/repository/client_auth_repository.dart';
import 'package:talktomylawyer/app/routes/app_pages.dart';

class ClientProfileTabController extends GetxController {
  Rxn<ClientModel> get clientModel => ClientAuthRepository.instance.clientData;

  void signOut() {
    ClientAuthRepository.instance.clearClientCredentials();
    Get.offAllNamed(Routes.clientLogin);
  }
}
