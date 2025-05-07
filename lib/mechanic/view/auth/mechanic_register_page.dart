import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_1/mechanic/view/auth/create_account/professional_details_page.dart';
import 'package:mini_project_1/utils/widgets.dart';

class MechanicRegisterPage extends StatefulWidget {
  const MechanicRegisterPage({super.key});

  @override
  State<MechanicRegisterPage> createState() => _MechanicRegisterPageState();
}

class _MechanicRegisterPageState extends State<MechanicRegisterPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Column(
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      Text(
                        textAlign: TextAlign.center,
                        'Fill your information below or register with your social account',
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  buildLabel('Name'),
                  CustomTextField(
                    text: 'Enter your Full Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
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
                      if (!RegExp(r'^[0-9]{10}$').hasMatch(value.trim())) {
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
                        return 'Password must be at least 8 characters,\ninclude upper & lower case letters,\na number, and a special character';
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
                        return 'Please confirm your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    controller: confirmPasswordController,
                  ),
                  const SizedBox(height: 30),
                  CustomMaterialButtom(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfessionalDetailsPage(),
                          ),
                        );
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
