import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:task_manager_application/app.dart';
import 'package:task_manager_application/presentation/controllers/auth_controller.dart';
import 'package:task_manager_application/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager_application/presentation/screens/update_profile_screen.dart';
import '../utils/app_colors.dart';

PreferredSizeWidget get profileAppBar {
  return AppBar(
    automaticallyImplyLeading: false, // remove back button
    backgroundColor: AppColors.themeColor,
    title: Row(
      children: [
        GestureDetector(
          child: CircleAvatar(
            //backgroundImage: MemoryImage(base64Decode(AuthController.userData!.photo!)),
          ),
          onTap: () {
            Navigator.push(TaskManager.navigatorKey.currentState!.context,
                MaterialPageRoute(builder: (context) => const UpdateProfileScreen()));
          },
        ),
        const SizedBox(
          width: 12,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AuthController.userData?.fullName ?? '',
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                AuthController.userData?.email ?? '',
                style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
        IconButton(
            onPressed: () async {
              await AuthController.clearUserData();
              Navigator.pushAndRemoveUntil(
                  TaskManager.navigatorKey.currentState!.context,
                  MaterialPageRoute(builder: (context) => SignInScreen()),
                  (route) => false);
            },
            icon: const Icon(Icons.logout, color: Colors.white,))
      ],
    ),
  );
}
