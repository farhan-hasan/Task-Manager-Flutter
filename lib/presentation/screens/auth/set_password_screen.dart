import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_application/presentation/controllers/set_password_controller.dart';
import 'package:task_manager_application/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/snack_bar_message.dart';

import '../../../data/services/network_caller.dart';
import '../../../data/utility/urls.dart';

class SetPasswordScreen extends StatefulWidget {

  final String email;
  final String otp;

  SetPasswordScreen({super.key, required this.otp, required this.email });

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passwordTEC = TextEditingController();
  final TextEditingController _confirmPasswordTEC = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final SetPasswordController _setPasswordController = Get.find<SetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Text(
                    "Set Password",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    "Minimum 8 characters with letters and number combination",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey
                    ),
                  ),
                  const SizedBox(height: 24,),
                  TextFormField(
                    controller: _passwordTEC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _confirmPasswordTEC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<SetPasswordController>(
                    builder: (setPasswordController) {
                      return Visibility(
                        visible: setPasswordController.inProgress == false,
                        replacement: const Center(child: CircularProgressIndicator(),),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () {
                                _setPassword(_passwordTEC.text, _confirmPasswordTEC.text);
                              },
                              child: const Text("Confirm")),
                        ),
                      );
                    }
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Have account?",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                      TextButton(
                          onPressed: () {
                            // Navigator.pushAndRemoveUntil(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => SignInScreen()),
                            //         (route) => false);
                            Get.offAll(() => const SignInScreen());
                          },
                          child: const Text("Sign in"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _setPassword(String password, String confirmPassword) async {

    if(password!=confirmPassword) {
      showSnackBarMessage(context, "Password does not match");
      return;
    }

    final result =
    await _setPasswordController.setPassword(widget.email, password, widget.otp);

    if (result) {
      if(mounted) {
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>  SignInScreen()), (route) => false,);
        Get.offAll(() => const SignInScreen());
      }
    } else {
      if(mounted) {
        showSnackBarMessage(context, _setPasswordController.errorMessage);
      }
    }
  }

  @override
  void dispose() {
    _passwordTEC.dispose();
    _confirmPasswordTEC.dispose();
    super.dispose();
  }
}
