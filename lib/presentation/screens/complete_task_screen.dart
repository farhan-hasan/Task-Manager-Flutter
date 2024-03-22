import 'package:flutter/material.dart';
import 'package:task_manager_application/data/models/task_list_wrapper.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/empty_list_widget.dart';

import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  bool _getAllCompletedTaskListInProgress = false;
  TaskListWrapper _completedTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getAllCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: RefreshIndicator(
        onRefresh: () async {
          _getAllCompletedTaskList();
        },
        child: BackgroundWidget(
          child: Visibility(
            visible: _getAllCompletedTaskListInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            // TODO : when list is empty, the refreshindicator is not working. make it work
            // TODO : hint -> it is not working when the list is empty
            child: Visibility(
              visible: _completedTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: EmptyListWidget(),
              child: ListView.builder(
                  itemCount: _completedTaskListWrapper.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                        taskItem: _completedTaskListWrapper.taskList![index],
                        refreshList: () {
                          _getAllCompletedTaskList();
                        });
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getAllCompletedTaskList() async {
    _getAllCompletedTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.completedTaskList);
    if (response.isSuccess) {
      _completedTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
      _getAllCompletedTaskListInProgress = false;
      setState(() {});
    } else {
      _getAllCompletedTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Completed task list retrieve failed');
      }
    }
  }
}
