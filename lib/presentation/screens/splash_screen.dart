import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_manager_application/presentation/screens/sign_in_screen.dart';
import 'package:task_manager_application/presentation/utils/assets_path.dart';
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
    _moveToSignIn();
  }

  Future<void> _moveToSignIn() async {
    await Future.delayed(const Duration(seconds: 2));
    if(mounted) { // check existence of this node in the widget tree
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignInScreen()));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: Center(
          child: AppLogo(),
        )
      )
    );
  }
}


