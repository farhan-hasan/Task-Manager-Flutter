import 'package:flutter/material.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/empty_list_widget.dart';

import '../../data/models/task_list_wrapper.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {

  bool _getAllInProgressTaskListInProgress = false;
  TaskListWrapper _inProgressTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getAllInProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: RefreshIndicator(
        onRefresh: () async {
          _getAllInProgressTaskList();
        },
        child: BackgroundWidget(
          child: Visibility(
            visible: _getAllInProgressTaskListInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: Visibility(
              visible: _inProgressTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: EmptyListWidget(),
              child: ListView.builder(
                  itemCount: _inProgressTaskListWrapper.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskItem: _inProgressTaskListWrapper.taskList![index],
                      refreshList: () {
                        _getAllInProgressTaskList();
                      },
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getAllInProgressTaskList() async {
    _getAllInProgressTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.inProgressTaskList);
    if (response.isSuccess) {
      _inProgressTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
      _getAllInProgressTaskListInProgress = false;
      setState(() {});
    } else {
      _getAllInProgressTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'In Progress task list retrieve failed');
      }
    }
  }

}
