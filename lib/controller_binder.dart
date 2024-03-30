
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:task_manager_application/presentation/controllers/cancelled_task_controller.dart';
import 'package:task_manager_application/presentation/controllers/complete_task_controller.dart';
import 'package:task_manager_application/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager_application/presentation/controllers/new_task_controller.dart';
import 'package:task_manager_application/presentation/controllers/progress_task_controller.dart';
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
  }
}