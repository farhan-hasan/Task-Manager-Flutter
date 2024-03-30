
import 'package:get/get.dart';
import 'package:task_manager_application/presentation/controllers/cancelled_task_controller.dart';
import 'package:task_manager_application/presentation/controllers/complete_task_controller.dart';
import 'package:task_manager_application/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager_application/presentation/controllers/email_verification_controller.dart';
import 'package:task_manager_application/presentation/controllers/new_task_controller.dart';
import 'package:task_manager_application/presentation/controllers/pin_verification_controller.dart';
import 'package:task_manager_application/presentation/controllers/progress_task_controller.dart';
import 'package:task_manager_application/presentation/controllers/set_password_controller.dart';
import 'package:task_manager_application/presentation/controllers/sign_in_controller.dart';
import 'package:task_manager_application/presentation/controllers/sign_up_controller.dart';

class ControllerBInder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.lazyPut(() => CountTaskByStatusController());
    Get.lazyPut(() => NewTaskController());
    Get.lazyPut(() => CompleteTaskController());
    Get.lazyPut(() => ProgressTaskController());
    Get.lazyPut(() => CancelledTaskController());
    Get.lazyPut(() => EmailVerificationController());
    Get.lazyPut(() => PinVerificationController());
    Get.lazyPut(() => SetPasswordController());
  }
}