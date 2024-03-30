import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_application/data/models/task_list_wrapper.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/empty_list_widget.dart';

import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import '../controllers/complete_task_controller.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {

  @override
  void initState() {
    super.initState();
    Get.find<CompleteTaskController>()
        .getCompleteTaskList();;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<CompleteTaskController>()
              .getCompleteTaskList();;
        },
        child: BackgroundWidget(
          child: GetBuilder<CompleteTaskController>(
              builder: (completeTaskController) {
            return Visibility(
              visible: completeTaskController.inProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              // TODO : when list is empty, the refreshindicator is not working. make it work
              // TODO : hint -> it is not working when the list is empty
              child: Visibility(
                visible: completeTaskController
                        .completeTaskListWrapper.taskList?.isNotEmpty ??
                    false,
                replacement: EmptyListWidget(),
                child: ListView.builder(
                    itemCount: completeTaskController
                            .completeTaskListWrapper.taskList?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return TaskCard(
                          taskItem: completeTaskController
                              .completeTaskListWrapper.taskList![index],
                          refreshList: () {
                            Get.find<CompleteTaskController>()
                                .getCompleteTaskList();;
                          });
                    }),
              ),
            );
          }),
        ),
      ),
    );
  }
}
