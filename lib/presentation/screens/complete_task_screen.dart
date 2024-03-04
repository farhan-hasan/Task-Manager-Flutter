import 'package:flutter/material.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';

import '../widgets/profile_app_bar.dart';
import '../widgets/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return TaskCard();
            }),
      ),
    );
  }
}
