import 'package:flutter/material.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/profile_app_bar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {

  final TextEditingController _titleTEC = TextEditingController();
  final TextEditingController _descriptionTEC = TextEditingController();
  final GlobalKey<FormState>  _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48,),
                Text("Add New Task", style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 24
                ),),
                const SizedBox(height: 16,),
                TextFormField(
                  controller: _titleTEC,
                  decoration: InputDecoration(
                    hintText: "Title"
                  ),
                ),
                const SizedBox(height: 8,),
                TextFormField(
                  controller: _descriptionTEC,
                  decoration: InputDecoration(
                    hintText: "Description"
                  ),
                  maxLines: 6,
                ),
                const SizedBox(height:16,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleTEC.dispose();
    _descriptionTEC.dispose();
    super.dispose();
  }

}
