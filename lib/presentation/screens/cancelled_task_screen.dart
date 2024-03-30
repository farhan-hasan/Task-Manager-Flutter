import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_application/presentation/controllers/cancelled_task_controller.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';

import '../widgets/empty_list_widget.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {


  @override
  void initState() {
    super.initState();
    Get.find<CancelledTaskController>().getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<CancelledTaskController>().getCancelledTaskList();
        },
        child: BackgroundWidget(
          child: GetBuilder<CancelledTaskController>(
            builder: (cancelledTaskController) {
              return Visibility(
                visible: cancelledTaskController.inProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                // TODO : when list is empty, the refreshindicator is not working. make it work
                // TODO : hint -> it is not working when the list is empty
                child: Visibility(
                  visible: cancelledTaskController.cancelledTaskListWrapper.taskList?.isNotEmpty ?? false,
                  replacement: EmptyListWidget(),
                  child: ListView.builder(
                      itemCount: cancelledTaskController.cancelledTaskListWrapper.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskCard(
                            taskItem: cancelledTaskController.cancelledTaskListWrapper.taskList![index],
                            refreshList: () {
                              Get.find<CancelledTaskController>().getCancelledTaskList();
                            });
                      }),
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
