import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_1/mechanic/view/auth/create_account/professional_details_page.dart';
import 'package:mini_project_1/utils/widgets.dart';

class ShopRegister extends StatelessWidget {
  const ShopRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'Create Account',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                        textAlign: TextAlign.center,
                        'Fill your information below or register with your social account'),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildLabel('Name'),
                    CustomTextField(
                      text: 'Enter your Full Name',
                      validator: (value) {},
                      controller: TextEditingController(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buildLabel('Mobile Number'),
                    CustomTextField(
                      text: 'Enter your Mobile ',
                      validator: (value) {},
                      controller: TextEditingController(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buildLabel('E-Mail'),
                    CustomTextField(
                      text: 'Enter your E-Mail',
                      validator: (value) {},
                      controller: TextEditingController(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buildLabel('Create Password'),
                    CustomTextField(
                      text: 'Create your Password',
                      validator: (value) {},
                      controller: TextEditingController(),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    buildLabel('Conform Password'),
                    CustomTextField(
                      text: 'Conform your Password',
                      validator: (value) {},
                      controller: TextEditingController(),
                    ),
                  ],
                ),
                CustomMaterialButtom(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfessionalDetailsPage(),
                          ));
                    },
                    buttonText: 'Sign up'),
                CustomRickText(
                    firstText: 'Doyou have an account? ',
                    secondText: 'Sign In',
                    onTap: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
