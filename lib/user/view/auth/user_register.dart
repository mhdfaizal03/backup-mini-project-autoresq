import 'package:flutter/material.dart';
import 'package:mini_project_1/admin/view/screens/home/user_home_screen.dart';
import 'package:mini_project_1/mechanic/view/auth/create_account/professional_details_page.dart';
import 'package:mini_project_1/user/models/services/firebase_auth_services.dart';
import 'package:mini_project_1/utils/colors.dart';
import 'package:mini_project_1/utils/messages.dart';
import 'package:mini_project_1/utils/widgets.dart';

class UserRegister extends StatefulWidget {
  const UserRegister({super.key});

  @override
  State<UserRegister> createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();
  final authService = FirebaseAuthServices();

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Create Account',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            textAlign: TextAlign.center,
                            'Fill your information below or register with your social account',
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildLabel('Name'),
                          CustomTextField(
                            text: 'Enter your Full Name',
                            validator: (value) {
                              if (value == null || value.isEmpty)
                                return 'Name is required';
                              return null;
                            },
                            controller: nameController,
                          ),
                          const SizedBox(height: 20),
                          buildLabel('Mobile Number'),
                          CustomTextField(
                            text: 'Enter your Mobile',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Mobile number is required';
                              }
                              if (!RegExp(r'^[0-9]{10}$')
                                  .hasMatch(value.trim())) {
                                return 'Enter a valid 10-digit mobile number';
                              }
                              return null;
                            },
                            controller: mobileController,
                          ),
                          const SizedBox(height: 20),
                          buildLabel('E-Mail'),
                          CustomTextField(
                            text: 'Enter your E-Mail',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              final emailRegex =
                                  RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                              if (!emailRegex.hasMatch(value.trim())) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                            controller: emailController,
                          ),
                          const SizedBox(height: 20),
                          buildLabel('Create Password'),
                          CustomTextField(
                            text: 'Create your Password',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              final passwordRegex = RegExp(
                                  r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
                              if (!passwordRegex.hasMatch(value.trim())) {
                                return 'Password must be at least 8 characters, include upper & lower case letters, a number, and a special character';
                              }
                              return null;
                            },
                            controller: passwordController,
                          ),
                          const SizedBox(height: 20),
                          buildLabel('Confirm Password'),
                          CustomTextField(
                            text: 'Confirm your Password',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Confirm password is required';
                              }
                              if (value != passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            controller: confirmPasswordController,
                          ),
                        ],
                      ),
                      CustomMaterialButtom(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            showLoadingDialog(context);

                            String? error = await authService.registerUser(
                                location: 'Not specified',
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                                mobile: mobileController.text.trim(),
                                profileUrl:
                                    'https://i.pinimg.com/736x/2c/47/d5/2c47d5dd5b532f83bb55c4cd6f5bd1ef.jpg');

                            Navigator.pop(context);

                            if (error == null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UsersHome(),
                                ),
                              );
                            } else {
                              CustomSnackBar.show(
                                  context: context,
                                  message: error,
                                  icon: Icons.warning_amber_rounded);
                            }
                          }
                        },
                        buttonText: 'Sign up',
                      ),
                      CustomRickText(
                        firstText: 'Do you have an account? ',
                        secondText: 'Sign In',
                        onTap: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
