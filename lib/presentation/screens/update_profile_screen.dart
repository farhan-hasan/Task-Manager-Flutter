import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager_application/data/services/network_caller.dart';
import 'package:task_manager_application/presentation/controllers/auth_controller.dart';
import 'package:task_manager_application/presentation/screens/main_bottom_nav_screen.dart';
import 'package:task_manager_application/presentation/widgets/background_widget.dart';
import 'package:task_manager_application/presentation/widgets/profile_app_bar.dart';
import 'package:task_manager_application/presentation/widgets/snack_bar_message.dart';

import '../../data/models/user_data.dart';
import '../../data/utility/urls.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController _emailTEC = TextEditingController();
  final TextEditingController _firstNameTEC = TextEditingController();
  final TextEditingController _lastNameTEC = TextEditingController();
  final TextEditingController _mobileTEC = TextEditingController();
  final TextEditingController _passwordTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _updateProfileInProgress = false;
  XFile? _pickedImage;

  @override
  void initState() {
    super.initState();
    _emailTEC.text = AuthController.userData?.email ?? '';
    _firstNameTEC.text = AuthController.userData?.firstName ?? '';
    _lastNameTEC.text = AuthController.userData?.lastName ?? '';
    _mobileTEC.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppBar,
      body: BackgroundWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 48,
                  ),
                  Text(
                    "Update Profile",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 24),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  imagePickerButton(),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTEC,
                    decoration: const InputDecoration(hintText: "Email"),
                  ),

                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _firstNameTEC,
                    decoration: const InputDecoration(hintText: "First Name"),
                    validator: (String? value) {
                      if(value?.trim().isNotEmpty ?? true) {
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
                    decoration: const InputDecoration(hintText: "Last Name"),
                    validator: (String? value) {
                      if(value?.trim().isNotEmpty ?? true) {
                        return 'Enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    controller: _mobileTEC,
                    decoration: const InputDecoration(hintText: "Mobile"),
                    validator: (String? value) {
                      if(value?.trim().isNotEmpty ?? true) {
                        return 'Enter your mobile number';
                      }
                      return null;
                    },
                    maxLength: 11,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _passwordTEC,
                    decoration:
                        const InputDecoration(hintText: "Password (Optional)"),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _updateProfileInProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            _updateProfile();
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget imagePickerButton() {
    return GestureDetector(
      onTap: () {
        pickImageFromGallery();
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8))),
              child: const Text(
                "Photo",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
              _pickedImage?.name ?? '',
              maxLines: 1,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
            ))
          ],
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
    setState(() {});
  }

  Future<void> _updateProfile() async {
    String? photo;

    _updateProfileInProgress = true;
    setState(() {});

    Map<String, dynamic> inputParams = {
      "email": _emailTEC.text.trim(),
      "firstName": _firstNameTEC.text.trim(),
      "lastName": _lastNameTEC.text.trim(),
      "mobile": _mobileTEC.text.trim(),
    };

    if (_passwordTEC.text.isNotEmpty) {
      inputParams['password'] = _passwordTEC.text;
    }

    if (_pickedImage != null) {
      List<int> bytes = File(_pickedImage!.path).readAsBytesSync();
      photo = base64Encode(bytes);
      inputParams['photo'] = photo;
    }

    final response =
        await NetworkCaller.postRequest(Urls.updateProfile, inputParams);
    _updateProfileInProgress = false;
    if (response.isSuccess) {
      if (response.responseBody['status'] == 'success') {
        UserData userData = UserData(
            email: _emailTEC.text,
            firstName: _firstNameTEC.text.trim(),
            lastName: _lastNameTEC.text.trim(),
            mobile: _mobileTEC.text.trim(),
            photo: photo);
        await AuthController.saveUserData(userData);
      }
      if(mounted) {
        // Navigator.pushAndRemoveUntil(
        //     context,
        //     MaterialPageRoute(builder: (context) => const MainBottomNavScreen()),
        //         (route) => false);
        Get.offAll(() => const MainBottomNavScreen());
      }
    } else {
      if (!mounted) {
        return;
      }
      setState(() {});
      showSnackBarMessage(context, 'Profile update failed.');
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
