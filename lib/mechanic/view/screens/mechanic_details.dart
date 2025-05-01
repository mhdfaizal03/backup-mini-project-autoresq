import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_1/mechanic/view/auth/mechanic_login_page.dart';
import 'package:mini_project_1/utils/colors.dart';
import 'package:mini_project_1/utils/widgets.dart';

class MechanicDetails extends StatefulWidget {
  MechanicDetails({super.key});

  @override
  State<MechanicDetails> createState() => _MechanicDetailsState();
}

class _MechanicDetailsState extends State<MechanicDetails> {
  bool isEdit = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  customAlertWidget(
                      context: context,
                      content: buildLabel('Do you want to delete your account'),
                      actions: [
                        MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Cancel')),
                        MaterialButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MechanicLoginPage(),
                                ),
                                (route) => false,
                              );
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return BackdropFilter(
                                        enabled: true,
                                        filter: ImageFilter.blur(
                                            sigmaX: 6, sigmaY: 6),
                                        child: CupertinoAlertDialog(
                                          content: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Icons.cancel_rounded,
                                                  color: Colors.red,
                                                  size: 80,
                                                ),
                                                Text(
                                                  "Account Deleted",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red),
                                                )
                                              ],
                                            ),
                                          ),
                                        ));
                                  });
                            },
                            child: Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            )),
                      ]);
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Delete Account',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    isEdit = !isEdit;
                  });
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      isEdit ? 'Edit' : 'Update',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.chevron_left),
                      Text(
                        'Back',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[200],
                      radius: 45,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Jack",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text('jack007@gmail.com'),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                buildLabel('Name'),
                CustomTextField(
                    readOnly: isEdit,
                    text: 'Name',
                    validator: (value) {},
                    controller: TextEditingController()),
                SizedBox(
                  height: 20,
                ),
                buildLabel('Mobile Number'),
                CustomTextField(
                    readOnly: isEdit,
                    text: 'Mobile Number',
                    validator: (value) {},
                    controller: TextEditingController()),
                SizedBox(
                  height: 20,
                ),
                buildLabel('E- Mail'),
                CustomTextField(
                    readOnly: isEdit,
                    text: 'E- Mail',
                    validator: (value) {},
                    controller: TextEditingController()),
                SizedBox(
                  height: 20,
                ),
                buildLabel('Password'),
                CustomTextField(
                    readOnly: isEdit,
                    text: 'Password',
                    validator: (value) {},
                    controller: TextEditingController()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
