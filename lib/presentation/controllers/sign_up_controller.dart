import 'package:get/get.dart';

import '../../data/models/response_object.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Registration Failed! Try again';

  Future<bool> signUp(String email, String firstName, String lastName, String mobile, String password) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };

    final ResponseObject response =
    await NetworkCaller.postRequest(
        Urls.registration, inputParams);

    _inProgress = false;

    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }

}