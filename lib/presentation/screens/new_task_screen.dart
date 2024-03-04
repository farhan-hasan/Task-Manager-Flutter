import 'package:flutter/material.dart';
import 'package:task_manager_application/presentation/screens/add_new_task_screen.dart';
import 'package:task_manager_application/presentation/utils/app_colors.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Column(
          children: [
            taskCounterSection,
            Expanded(
                child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return TaskCard();
                    }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewTaskScreen()));
        },
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
      ),
    );
  }

  Widget get taskCounterSection {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return const TaskCounterCard(
                title: 'New',
                amount: 23,
              );
            },
            separatorBuilder: (_, __) {
              return const SizedBox(
                width: 8,
              );
            },
            itemCount: 4),
      ),
    );
  }
}
