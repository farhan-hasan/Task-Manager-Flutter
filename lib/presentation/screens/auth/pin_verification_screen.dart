import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_application/presentation/controllers/pin_verification_controller.dart';
import 'package:task_manager_application/presentation/screens/auth/set_password_screen.dart';
import 'package:task_manager_application/presentation/screens/auth/sign_in_screen.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';

import '../../../data/services/network_caller.dart';
import '../../../data/utility/urls.dart';
import '../../utils/app_colors.dart';
import '../../widgets/snack_bar_message.dart';


class PinVerificationScreen extends StatefulWidget {
  final String email;

  PinVerificationScreen({required this.email});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinTEC = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final PinVerificationController _pinVerificationController = Get.find<PinVerificationController>();

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
                    "PIN Verification",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
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
                  PinCodeTextField(
                    controller: _pinTEC,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                      inactiveFillColor: Colors.white,
                      inactiveColor: AppColors.themeColor,
                      selectedFillColor: Colors.white
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.transparent,
                    enableActiveFill: true,
                    onCompleted: (v) {},
                    onChanged: (value) {},
                    appContext: context,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GetBuilder<PinVerificationController>(
                    builder: (pinVerificationController) {
                      return Visibility(
                        visible: pinVerificationController.inProgress == false,
                        replacement: const Center(child: CircularProgressIndicator(),),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                              onPressed: () async {
                                _verifyPin(_pinTEC.text.trim());
                              }, child: const Text("Verify")),
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

  Future<void> _verifyPin(String pin) async {
    String email = widget.email;
    final result = await _pinVerificationController.verifyPin(email, pin);

    if (result) {
      if(mounted) {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>  SetPasswordScreen(otp: pin, email: widget.email,)));
        Get.to(() => SetPasswordScreen(otp: pin, email: widget.email,));
      }
    } else {
      if(mounted) {
        showSnackBarMessage(context, _pinVerificationController.errorMessage);
      }
    }
  }

  @override
  void dispose() {
    _pinTEC.dispose();
    super.dispose();
  }
}
