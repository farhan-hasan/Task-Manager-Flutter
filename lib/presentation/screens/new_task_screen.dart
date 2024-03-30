import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_application/data/models/task_count_by_status_data.dart';
import 'package:task_manager_application/data/models/task_list_wrapper.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/presentation/controllers/count_task_by_status_controller.dart';
import 'package:task_manager_application/presentation/controllers/new_task_controller.dart';
import 'package:task_manager_application/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager_application/presentation/utils/app_colors.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/snack_bar_message.dart';

import '../../data/utility/urls.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/task_card.dart';
import '../widgets/task_counter_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    _getDataFromApis();
  }

  void _getDataFromApis() {
    Get.find<CountTaskByStatusController>().getCountByTaskStatus();
    Get.find<NewTaskController>().getNewTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Column(
          children: [
            GetBuilder<CountTaskByStatusController>(
                builder: (countTaskByStatusController) {
              return Visibility(
                  visible: countTaskByStatusController.inProgress == false,
                  replacement: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(),
                  ),
                  child: taskCounterSection(countTaskByStatusController
                          .countByStatusWrapper.listOfTaskByStatusData ??
                      []));
            }),
            Expanded(child:
                GetBuilder<NewTaskController>(builder: (newTaskController) {
              return Visibility(
                visible: newTaskController.inProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: () async => _getDataFromApis(),
                  child: Visibility(
                    visible: newTaskController
                            .newTaskListWrapper.taskList?.isNotEmpty ??
                        false,
                    replacement: EmptyListWidget(),
                    child: ListView.builder(
                        itemCount: newTaskController
                                .newTaskListWrapper.taskList?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            taskItem: newTaskController
                                .newTaskListWrapper.taskList![index],
                            refreshList: () {
                              _getDataFromApis();
                            },
                          );
                        }),
                  ),
                ),
              );
            }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewTaskScreen()));
          if (result != null && result == true) {
            _getDataFromApis();
          }
        },
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget taskCounterSection(
      List<TaskCountByStatusData> listOfTaskCountByStatus) {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: listOfTaskCountByStatus.length,
          itemBuilder: (BuildContext context, int index) {
            return TaskCounterCard(
              title: listOfTaskCountByStatus[index].sId ?? '',
              amount: listOfTaskCountByStatus[index].sum ?? 0,
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 8,
            );
          },
        ),
      ),
    );
  }
}
