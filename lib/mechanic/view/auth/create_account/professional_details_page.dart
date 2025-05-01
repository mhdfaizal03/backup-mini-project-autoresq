import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_1/main.dart';
import 'package:mini_project_1/mechanic/view/auth/mechanic_login_page.dart';
import 'package:mini_project_1/mechanic/view/screens/Mechanic_navbar_page.dart';
import 'package:mini_project_1/utils/colors.dart';
import 'package:mini_project_1/utils/widgets.dart';

class ProfessionalDetailsPage extends StatefulWidget {
  ProfessionalDetailsPage({super.key});

  @override
  State<ProfessionalDetailsPage> createState() =>
      _ProfessionalDetailsPageState();
}

class _ProfessionalDetailsPageState extends State<ProfessionalDetailsPage> {
  int? selectedIndex;

  List<String> experience = ["0-2 Year", "2-5 Year", "5+ Year"];

  List<String> specifications = [
    "Engine Repair",
    "Brake System Repair",
    "Transmission Services",
    "Electrical System Repair",
    "Suspension & Steering",
    "Air Conditioning & Heating",
    "Tyre & Wheel Services",
    "Battery & Charging System",
    "Hybrid & EV Maintenance",
  ];

  List<String> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: mq.height),
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Professional Details',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            textAlign: TextAlign.center,
                            'Enter your works and workshop details for verification.'),
                        SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey[200],
                            ),
                            Positioned(
                              bottom: 0,
                              right: 10,
                              child: CircleAvatar(
                                radius: 15,
                                backgroundColor: primaryColor,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildLabel('Workshop Name'),
                        CustomTextField(
                            text: 'Enter your Workshop Name',
                            validator: (value) {},
                            controller: TextEditingController()),
                        SizedBox(
                          height: 20,
                        ),
                        buildLabel('Workshop Address'),
                        CustomTextField(
                            maxLines: 5,
                            text: 'Workshop Address',
                            validator: (value) {},
                            controller: TextEditingController()),
                        SizedBox(
                          height: 20,
                        ),
                        buildLabel('Experience'),
                        Row(
                          children: List.generate(
                            3,
                            (index) {
                              return Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      },
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  blurRadius: 1.5,
                                                  color: Colors.grey)
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: selectedIndex == index
                                                ? primaryColor
                                                : Colors.white),
                                        child: Center(
                                          child: Text(
                                            experience[index],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: selectedIndex == index
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ),
                                      ),
                                    )),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        buildLabel('ID Proof'),
                        Row(
                          children: [
                            Expanded(
                                flex: 3,
                                child: CustomTextField(
                                    readOnly: true,
                                    text: 'Add ID Proof',
                                    validator: (value) {},
                                    controller: TextEditingController())),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                height: 55,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 1.5, color: Colors.grey)
                                    ],
                                    borderRadius: BorderRadius.circular(10),
                                    color: primaryColor),
                                child: Center(
                                  child: Text(
                                    'Add',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            buildLabel(
                              'Specializations',
                            ),
                            Text(
                              '(Max 6 Specializations)',
                              style: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                        CustomTextField(
                            readOnly: true,
                            suffix: IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return CustomSpecificationsDialog(
                                          headerItems: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 18),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Select Specializations',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  '(Max 6)',
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                              ],
                                            ),
                                          ),
                                          context: context,
                                          children: List.generate(
                                            specifications.length,
                                            (index) {
                                              String item =
                                                  specifications[index];
                                              bool isSelected =
                                                  selectedItems.contains(item);

                                              return Column(
                                                children: [
                                                  Divider(),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 12,
                                                        vertical: 6),
                                                    child: InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          if (isSelected) {
                                                            selectedItems
                                                                .remove(item);
                                                          } else if (selectedItems
                                                                  .length <
                                                              6) {
                                                            selectedItems
                                                                .add(item);
                                                          }
                                                        });
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 5.0),
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                                child:
                                                                    Text(item)),
                                                            Icon(isSelected
                                                                ? Icons
                                                                    .radio_button_on
                                                                : Icons
                                                                    .radio_button_off),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          actionButton: MaterialButton(
                                            height: 60,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ),
                                            minWidth: double.infinity,
                                            color: Colors.blue[500],
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              'Save',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                              ),
                            ),
                            text: selectedItems.isEmpty
                                ? 'Select Specializations'
                                : '${selectedItems.length} Specializations selected',
                            validator: (value) {},
                            controller: TextEditingController()),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CustomMaterialButtom(
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
                                  filter:
                                      ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                  child: CupertinoAlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.check_circle,
                                          size: 100,
                                          color: Colors.green,
                                        ),
                                        Text(
                                            textAlign: TextAlign.center,
                                            'Requested\nSuccessfully',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          buttonText: 'Request for Account Creation'),
                    ),
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
