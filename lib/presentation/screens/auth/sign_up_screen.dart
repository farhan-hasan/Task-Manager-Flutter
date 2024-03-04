import 'package:flutter/material.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/snack_bar_message.dart';

import '../../../data/models/response_object.dart';
import '../../../data/utility/urls.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _firstNameTEC = TextEditingController();
  final TextEditingController _lastNameTEC = TextEditingController();
  final TextEditingController _mobileTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isRegistrationInProgress = false;

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
                    height: 60,
                  ),
                  Text(
                    "Join With Us",
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _emailTEC,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String? value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _firstNameTEC,
                    decoration: const InputDecoration(
                      hintText: 'First Name',
                    ),
                    validator: (String? value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return 'Enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _lastNameTEC,
                    decoration: const InputDecoration(
                      hintText: 'Last Name',
                    ),
                    validator: (String? value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return 'Enter last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _mobileTEC,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: 'Mobile',
                    ),
                    validator: (String? value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return 'Enter your mobile number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordTEC,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      if (value
                          ?.trim()
                          .isEmpty ?? true) {
                        return 'Enter your password';
                      }
                      if (value!.length <= 6) {
                        return 'Password length must be greater than 6';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _isRegistrationInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                          onPressed: ()  {
                            if (_formkey.currentState!.validate()) {
                              _signUp();
                            }
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
                            Navigator.pop(context);
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

  Future<void> _signUp() async {
    Map<String, dynamic> inputParams = {
      "email": _emailTEC.text.trim(),
      "firstName": _firstNameTEC.text.trim(),
      "lastName": _lastNameTEC.text.trim(),
      "mobile": _mobileTEC.text.trim(),
      "password": _passwordTEC.text,
    };
    _isRegistrationInProgress = true;
    setState(() {});
    final ResponseObject response =
    await NetworkCaller.postRequest(
        Urls.registration, inputParams);
    _isRegistrationInProgress = false;
    setState(() {});
    if (response.isSuccess) {
      if (mounted) {
        showSnackBarMessage(
            context,
            "Registration Successfull! Please login");
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        showSnackBarMessage(
            context, "Registration Failed! Try again",
            true);
      }
    }
  }

  @override
  void dispose() {
    _emailTEC.dispose();
    _firstNameTEC.dispose();
    _lastNameTEC.dispose();
    _mobileTEC.dispose();
    _passwordTEC.dispose();
    super.dispose();
  }
}
