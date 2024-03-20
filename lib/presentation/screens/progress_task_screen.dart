import 'package:flutter/material.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';

import '../widgets/profile_app_bar.dart';
import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              //return TaskCard();
            }),
      ),
    );
  }
}
