import 'package:get/get.dart';

import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class SetPasswordController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Set password failed';

  Future<bool> setPassword(String email, String password, String otp) async {
    bool isSuccess = false;
    _inProgress = true;

    Map<String,dynamic> inputParams = {
      "email":email,
      "OTP":otp,
      "password":password
    };

    update();
    final response =
    await NetworkCaller.postRequest(Urls.setPassword, inputParams);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}