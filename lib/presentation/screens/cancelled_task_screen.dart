import 'package:flutter/material.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';

import '../../data/models/task_list_wrapper.dart';
import '../../data/services/network_caller.dart';
import '../../data/utility/urls.dart';
import '../widgets/empty_list_widget.dart';
import '../widgets/profile_app_bar.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {

  bool _getAllCancelledTaskListInProgress = false;
  TaskListWrapper _cancelledTaskListWrapper = TaskListWrapper();

  @override
  void initState() {
    super.initState();
    _getAllCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: RefreshIndicator(
        onRefresh: () async {
          _getAllCancelledTaskList();
        },
        child: BackgroundWidget(
          child: Visibility(
            visible: _getAllCancelledTaskListInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            // TODO : when list is empty, the refreshindicator is not working. make it work
            // TODO : hint -> it is not working when the list is empty
            child: Visibility(
              visible: _cancelledTaskListWrapper.taskList?.isNotEmpty ?? false,
              replacement: EmptyListWidget(),
              child: ListView.builder(
                  itemCount: _cancelledTaskListWrapper.taskList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                        taskItem: _cancelledTaskListWrapper.taskList![index],
                        refreshList: () {
                          _getAllCancelledTaskList();
                        });
                  }),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getAllCancelledTaskList() async {
    _getAllCancelledTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.cancelledTaskList);
    if (response.isSuccess) {
      _cancelledTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
      _getAllCancelledTaskListInProgress = false;
      setState(() {});
    } else {
      _getAllCancelledTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Cancelled task list retrieve failed');
      }
    }
  }

}
