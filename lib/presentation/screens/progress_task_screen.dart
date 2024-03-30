import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_application/presentation/controllers/progress_task_controller.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/empty_list_widget.dart';

import '../widgets/profile_app_bar.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProgressTaskController>().getProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<ProgressTaskController>().getProgressTaskList();
        },
        child: BackgroundWidget(
          child: GetBuilder<ProgressTaskController>(
              builder: (progressTaskController) {
            return Visibility(
              visible: progressTaskController.inProgress == false,
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
              child: Visibility(
                visible: progressTaskController
                        .progressTaskListWrapper.taskList?.isNotEmpty ??
                    false,
                replacement: const EmptyListWidget(),
                child: ListView.builder(
                    itemCount: progressTaskController
                            .progressTaskListWrapper.taskList?.length ??
                        0,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        taskItem: progressTaskController
                            .progressTaskListWrapper.taskList![index],
                        refreshList: () {
                          Get.find<ProgressTaskController>()
                              .getProgressTaskList();
                        },
                      );
                    }),
              ),
            );
          }),
        ),
      ),
    );
  }
}
