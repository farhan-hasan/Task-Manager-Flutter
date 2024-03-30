import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/presentation/screens/auth/pin_verification_screen.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/snack_bar_message.dart';

import '../../../data/utility/urls.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTEC = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _verifyEmailInProgress = false;

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
                    "Your Email Address",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    "A 6 digit verification code will be sent to your email address",
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    controller: _emailTEC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: _verifyEmailInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            _verifyEmail();
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
                    ),
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
                            //Navigator.pop(context);
                            Get.back();
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

  Future<void> _verifyEmail() async {
    _verifyEmailInProgress = true;
    setState(() {});
    final response =
        await NetworkCaller.getRequest(Urls.verifyEmail(_emailTEC.text.trim()));
    _verifyEmailInProgress = false;
    if (response.isSuccess) {
      if (mounted) {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             PinVerificationScreen(email: _emailTEC.text.trim(),)));
        Get.to(() => PinVerificationScreen(email: _emailTEC.text.trim(),));
      }
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Email verification failed');
      }
    }
  }

  @override
  void dispose() {
    _emailTEC.dispose();
    super.dispose();
  }
}
