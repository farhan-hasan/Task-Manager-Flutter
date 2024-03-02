import 'package:flutter/material.dart';
import 'package:task_manager_application/presentation/screens/splash_screen.dart';
import 'package:task_manager_application/presentation/utils/app_colors.dart';

class TaskManager extends StatelessWidget {
  const TaskManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Task Manager",
      home: SplashScreen(),
      theme: ThemeData(
          inputDecorationTheme: InputDecorationTheme(
              fillColor: Colors.white,
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8))),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: AppColors.themeColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12))),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: AppColors.themeColor,
                  textStyle:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 16))),
          textTheme: TextTheme(
            titleLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          )
        ),
    );
  }
}
