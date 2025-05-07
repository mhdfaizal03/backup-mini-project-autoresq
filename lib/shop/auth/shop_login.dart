import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_1/common_screens/bottom_navbar_screen.dart';
import 'package:mini_project_1/mechanic/view/auth/mechanic_register_page.dart';
import 'package:mini_project_1/mechanic/view/screens/Mechanic_Navbar_Page.dart';
import 'package:mini_project_1/utils/colors.dart';
import 'package:mini_project_1/utils/messages.dart';
import 'package:mini_project_1/utils/widgets.dart';
import 'package:mini_project_1/common_screens/toggle_button_screen.dart';

class ShopLogin extends StatefulWidget {
  const ShopLogin({super.key});

  @override
  State<ShopLogin> createState() => _ShopLoginState();
}

class _ShopLoginState extends State<ShopLogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Hero(
                        tag: 'tow',
                        key: GlobalKey(),
                        child: Image.asset(
                          'assets/icons/tow.png',
                          width: 140,
                        )),
                    Column(
                      children: [
                        Text(
                          "Sign in",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Hi, Welcome back, you’ve been missed",
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Mobile or E-mail",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your email to continue';
                            }
                            final emailRegex =
                                RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                            if (!emailRegex.hasMatch(value.trim())) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                          text: 'Enter your Mobile or E-Mail',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Password",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your password to continue';
                            }
                            final passwordRegex = RegExp(
                                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$');
                            if (!passwordRegex.hasMatch(value.trim())) {
                              return '${value.length > 8 ? '✔️' : '✖️'} Password must be at least 8 characters\n${value.contains(RegExp(r'[A-Z]')) ? '✔️' : '✖️'}Include upper/lowercase letters\n${value.contains(RegExp(r'(\d)([\W_])')) ? '✔️' : '✖️'}Number, and special character';
                            }
                            return null;
                          },
                          text: 'Enter your Password',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: primaryColor,
                                fontSize: 14,
                                color: primaryColor),
                          ),
                        ),
                      ],
                    ),
                    CustomMaterialButtom(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MechanicNavbarPage(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        buttonText: 'Sign in'),
                    CustomRickText(
                        firstText: 'Don’t have an account? ',
                        secondText: 'Sign Up',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MechanicRegisterPage(),
                              ));
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
