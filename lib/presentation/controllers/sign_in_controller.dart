import 'package:get/get.dart';
import 'package:task_manager_application/data/services/network_caller.dart';

import '../../data/models/login_response.dart';
import '../../data/models/response_object.dart';
import '../../data/utility/urls.dart';
import 'auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Login Failed! Try again';

  Future<bool> signIn(String email, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> inputParams = {"email": email, "password": password};
    final ResponseObject response = await NetworkCaller.postRequest(
        Urls.login, inputParams,
        fromSignIn: true);

    _inProgress = false;

    if (response.isSuccess) {
      LoginResponse loginResponse =
          LoginResponse.fromJson(response.responseBody);
      // // Save the data to local cache
      await AuthController.saveUserData(loginResponse.userData!);
      await AuthController.saveUserToken(loginResponse.token!);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
