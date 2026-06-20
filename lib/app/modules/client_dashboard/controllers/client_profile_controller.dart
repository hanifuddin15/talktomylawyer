import 'package:get/get.dart';
import 'package:talktomylawyer/app/models/client_models/client_user_model.dart';
import 'package:talktomylawyer/app/repository/client_auth_repository.dart';

class ClientProfileTabController extends GetxController {
  final ClientModel clientModel =
      ClientAuthRepository.instance.getClientData() ?? ClientModel();
}
