import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_application/presentation/controllers/auth_controller.dart';
import 'package:task_manager_application/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager_application/presentation/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';

import '../widgets/app_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));

    bool isLoggedIn = await AuthController.isUserLoggedIn();

    if (mounted) {
      // check existence of this node in the widget tree
      if (isLoggedIn) {
        // Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => const MainBottomNavScreen()));
        Get.off(() => const MainBottomNavScreen());
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignInScreen()));
        Get.off(() => const SignInScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: BackgroundWidget(
            child: Center(
      child: AppLogo(),
    )));
  }
}
