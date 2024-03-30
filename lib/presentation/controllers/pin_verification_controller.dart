import 'package:get/get.dart';

import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';

class PinVerificationController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Pin verification failed';

  Future<bool> verifyPin(String email, String pin) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response =
    await NetworkCaller.getRequest(Urls.verifyPin(email, pin));
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