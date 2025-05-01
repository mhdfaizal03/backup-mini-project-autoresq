import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_1/utils/messages.dart';
import 'package:mini_project_1/utils/widgets.dart';

class MechanicHomePage extends StatefulWidget {
  const MechanicHomePage({super.key});

  @override
  State<MechanicHomePage> createState() => _MechanicHomePageState();
}

class _MechanicHomePageState extends State<MechanicHomePage> {
  static bool isExpanded = false;
  static int selectedIndex = 0;
  final List<Map<String, dynamic>> transactions = [
    {
      'mechanicName': 'AutoFix Garage',
      'status': 'Pending',
      'date': '11/02/25',
      'time': '9.15am',
      'place': 'Main Road, Eranhipalam, Kozhikode',
      'phoneNo': '+91 9988776655',
      'services': ['Battery Replacement', 'Coolant Refill'],
      'assignedMechanicName': 'Arun K.',
      'issueText':
          'My car won’t start and there’s a burnt smell coming from the hood. Possibly an electrical issue.',
      'location': '221B Baker Street, London, UK 12345',
      'isPaid': false,
    },
    {
      'mechanicName': 'QuickServe Mechanics',
      'status': 'Mechanic Picked',
      'date': '11/02/25',
      'time': '12.00pm',
      'place': 'Hilite Mall, Calicut',
      'phoneNo': '+91 9123456780',
      'services': ['Flat Tire Fix', 'Brake Fluid Check'],
      'assignedMechanicName': 'Sajid R.',
      'issueText':
          'Rear tire went flat while driving. Brake response also feels sluggish. Needs urgent attention.',
      'location': '102 Greenway Rd, Calicut, Kerala 673016',
      'isPaid': false,
    },
    {
      'mechanicName': 'Urban Auto Aid',
      'status': 'Work in Progress',
      'date': '11/02/25',
      'time': '2.45pm',
      'place': 'Calicut Beach Side',
      'phoneNo': '+91 9543217890',
      'services': ['Engine Diagnostics'],
      'assignedMechanicName': 'Nihal Thomas',
      'issueText':
          'Strange knocking noise from engine. Possible fuel injection issue. Diagnostics required.',
      'location': 'Beach Road, Kozhikode, Kerala 673001',
      'isPaid': false,
    },
    {
      'mechanicName': 'RoadRescue Services',
      'status': 'On the Way',
      'date': '11/02/25',
      'time': '4.10pm',
      'place': 'Medical College Road, Kozhikode',
      'phoneNo': '+91 9078654321',
      'services': ['Tow Service', 'Jump Start'],
      'assignedMechanicName': 'Deepak V.',
      'issueText':
          'Car battery died while parked overnight. Engine doesn’t crank. Possibly needs towing.',
      'location': '14 Parkway Ave, Kozhikode, Kerala 673008',
      'isPaid': true, // Payment made
    },
    {
      'mechanicName': 'SpeedyFix Auto',
      'status': 'Work Completed',
      'date': '11/02/25',
      'time': '6.30pm',
      'place': 'Kunduparamba, Kozhikode',
      'phoneNo': '+91 9876543210',
      'services': ['Oil Change', 'AC Service'],
      'assignedMechanicName': 'Rajeesh K.',
      'issueText':
          'Scheduled maintenance. AC not cooling efficiently and needs oil change as per service schedule.',
      'location': '23/4 Station Road, Kozhikode, Kerala 673009',
      'isPaid': true,
    },
    {
      'mechanicName': 'Express Auto Repair',
      'status': 'Pending',
      'date': '12/02/25',
      'time': '10.00am',
      'place': 'City Center, Kozhikode',
      'phoneNo': '+91 9812345678',
      'services': ['Alternator Replacement'],
      'assignedMechanicName': 'Vishal Kumar',
      'issueText':
          'Car battery keeps draining. Suspect alternator issues. Needs urgent diagnosis.',
      'location': '45 Elm Street, Calicut, Kerala 673016',
      'isPaid': false,
    },
    {
      'mechanicName': 'SuperFast Auto Care',
      'status': 'Mechanic Picked',
      'date': '12/02/25',
      'time': '11.30am',
      'place': 'Nadakkavu, Kozhikode',
      'phoneNo': '+91 9523678412',
      'services': ['Headlight Replacement', 'Tire Rotation'],
      'assignedMechanicName': 'Sameer K.',
      'issueText':
          'One of the headlights is not working, and tires need rotation as part of regular service.',
      'location': '17 Sunrise Avenue, Calicut, Kerala 673002',
      'isPaid': false,
    },
    {
      'mechanicName': 'CarFix Experts',
      'status': 'Work in Progress',
      'date': '12/02/25',
      'time': '3.00pm',
      'place': 'Mavoor Road, Kozhikode',
      'phoneNo': '+91 9638527410',
      'services': ['Brake Pad Replacement'],
      'assignedMechanicName': 'Anil Joseph',
      'issueText':
          'Brakes making a squeaking noise. Mechanic suggested brake pad replacement.',
      'location': '101 Baker Street, Calicut, Kerala 673001',
      'isPaid': false,
    },
    {
      'mechanicName': 'ProAuto Services',
      'status': 'On the Way',
      'date': '12/02/25',
      'time': '5.15pm',
      'place': 'Puthiyara, Kozhikode',
      'phoneNo': '+91 9958473210',
      'services': ['Suspension Repair'],
      'assignedMechanicName': 'Dinesh P.',
      'issueText':
          'Noticed excessive bouncing while driving. Possible issue with car suspension.',
      'location': '29 St. Mary’s Lane, Calicut, Kerala 673005',
      'isPaid': true,
    },
    {
      'mechanicName': 'AutoTech Solutions',
      'status': 'Work Completed',
      'date': '12/02/25',
      'time': '7.00pm',
      'place': 'Malaparamba, Kozhikode',
      'phoneNo': '+91 9987654321',
      'services': ['Transmission Fluid Change'],
      'assignedMechanicName': 'Fahad A.',
      'issueText':
          'Car struggles to shift gears smoothly. Transmission fluid change was recommended.',
      'location': '77 King’s Road, Calicut, Kerala 673009',
      'isPaid': true,
    },
    {
      'mechanicName': 'FastFix Garage',
      'status': 'Pending',
      'date': '13/02/25',
      'time': '8.30am',
      'place': 'Palayam, Kozhikode',
      'phoneNo': '+91 9123456789',
      'services': ['Exhaust System Repair'],
      'assignedMechanicName': 'Rahul T.',
      'issueText':
          'Loud noise from the exhaust. Mechanic recommended checking the exhaust system.',
      'location': '55 Maple Street, Calicut, Kerala 673003',
      'isPaid': false,
    },
  ];

  List<String> status = [];
  bool isSelected = false;

  List<String> selectedItems = [
    "Mechanic Picked",
    "On the Way",
    "Work in Progress",
    "Work Completed",
  ];

  String? pickedItem;

  @override
  Widget build(BuildContext context) {
    final filterdDatas = transactions.where(
      (ind) {
        if (selectedIndex == 0) {
          return ind['status'] == 'Pending';
        } else {
          return ind['status'] != 'Pending';
        }
      },
    ).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: [
          CustomToggleSwitch(
              onToggle: (int? index) {
                setState(() {
                  selectedIndex = index!;
                });
                print(selectedIndex);
              },
              selectedIndex: selectedIndex,
              labels: ['Requests', 'Accepted'],
              switches: 2),
          SizedBox(
            height: 20,
          ),
          filterdDatas.isEmpty
              ? Align(
                  alignment: Alignment.center,
                  child: Text(
                    'No data found',
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  itemCount: filterdDatas.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final transaction = filterdDatas[index];
                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                child: CustomRequestAcceptAlertDialog(
                                    assignedMechanicName:
                                        transaction['assignedMechanicName'],
                                    buttonEnterText:
                                        transaction['status'] == 'Pending'
                                            ? 'Accept'
                                            : 'Save',
                                    date: transaction['date'],
                                    isExpanded: isExpanded,
                                    issueText: transaction['issueText'],
                                    location: transaction['location'],
                                    pickStatus:
                                        transaction['status'] == 'Pending'
                                            ? 'No Mechanic Picked'
                                            : transaction['status'],
                                    serviceLength:
                                        transaction['services'].length,
                                    serviceText: transaction['services'],
                                    specificationsSelectText:
                                        '${transaction['services'].length} Service selected',
                                    onChooseStatusAction: () {
                                      pickedItem = transaction['status'];

                                      if (transaction['status'] != 'Pending') {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            String? tempPickedItem =
                                                transaction['status'];

                                            return StatefulBuilder(
                                              builder:
                                                  (context, setDialogState) {
                                                return CustomSpecificationsDialog(
                                                  headerItems: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 20,
                                                        vertical: 18),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        'Select Status',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                  context: context,
                                                  children: List.generate(
                                                    selectedItems.length,
                                                    (index) {
                                                      final item =
                                                          selectedItems[index];

                                                      return Column(
                                                        children: [
                                                          Divider(),
                                                          InkWell(
                                                            onTap: () {
                                                              if (item ==
                                                                      'Work Completed' &&
                                                                  transaction[
                                                                          'isPaid'] !=
                                                                      true) {
                                                                Navigator.pop(
                                                                    context);
                                                                CustomSnackBar.show(
                                                                    context:
                                                                        context,
                                                                    message:
                                                                        'Cannot mark as Completed before payment.',
                                                                    color: Colors
                                                                        .red,
                                                                    icon: Icons
                                                                        .error);

                                                                return;
                                                              }

                                                              setDialogState(
                                                                  () {
                                                                tempPickedItem =
                                                                    item;
                                                              });

                                                              setDialogState(
                                                                  () {
                                                                transaction[
                                                                        'status'] =
                                                                    item;
                                                              });

                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                          12,
                                                                      vertical:
                                                                          10),
                                                              child: Row(
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      item,
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .grey
                                                                              .shade700),
                                                                    ),
                                                                  ),
                                                                  Icon(
                                                                    tempPickedItem ==
                                                                            item
                                                                        ? Icons
                                                                            .radio_button_checked
                                                                        : Icons
                                                                            .radio_button_off,
                                                                    color: Colors
                                                                            .grey[
                                                                        600],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                  actionButton: MaterialButton(
                                                    height: 60,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(10),
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
                                                      'Close',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        );
                                      }
                                    },
                                    // onChooseStatusAction: () {
                                    //   pickedItem = transaction['status'];

                                    //   if (transaction['status'] != 'Pending') {
                                    //     showDialog(
                                    //       context: context,
                                    //       builder: (context) {
                                    //         String? tempPickedItem =
                                    //             transaction['status'];
                                    //         return StatefulBuilder(
                                    //           builder: (context, setDialogState) {
                                    //             return CustomSpecificationsDialog(
                                    //               headerItems: Padding(
                                    //                 padding: const EdgeInsets
                                    //                     .symmetric(
                                    //                     horizontal: 20,
                                    //                     vertical: 18),
                                    //                 child: Align(
                                    //                   alignment:
                                    //                       Alignment.centerLeft,
                                    //                   child: Text(
                                    //                     'Select Status',
                                    //                     style: TextStyle(
                                    //                         fontWeight:
                                    //                             FontWeight.bold),
                                    //                   ),
                                    //                 ),
                                    //               ),
                                    //               context: context,
                                    //               children: List.generate(
                                    //                 selectedItems.length,
                                    //                 (index) {
                                    //                   final item =
                                    //                       selectedItems[index];

                                    //                   return Column(
                                    //                     children: [
                                    //                       Divider(),
                                    //                       InkWell(
                                    //                         onTap: () {
                                    //                           if (item ==
                                    //                                   'Work Completed' &&
                                    //                               transaction[
                                    //                                       'isPaid'] !=
                                    //                                   true) {
                                    //                             Navigator.pop(
                                    //                                 context);
                                    //                             Navigator.pop(
                                    //                                 context);
                                    //                             ScaffoldMessenger
                                    //                                     .of(context)
                                    //                                 .showSnackBar(
                                    //                               SnackBar(
                                    //                                 behavior:
                                    //                                     SnackBarBehavior
                                    //                                         .floating,
                                    //                                 margin:
                                    //                                     EdgeInsets
                                    //                                         .all(
                                    //                                             20),
                                    //                                 content: Text(
                                    //                                     'Cannot mark as Completed before payment.'),
                                    //                                 backgroundColor:
                                    //                                     Colors
                                    //                                         .red,
                                    //                               ),
                                    //                             );
                                    //                             return;
                                    //                           }

                                    //                           setDialogState(() {
                                    //                             tempPickedItem =
                                    //                                 item;
                                    //                           });

                                    //                           setState(() {
                                    //                             transaction[
                                    //                                     'status'] =
                                    //                                 item;
                                    //                           });
                                    //                         },
                                    //                         child: Padding(
                                    //                           padding:
                                    //                               const EdgeInsets
                                    //                                   .symmetric(
                                    //                                   horizontal:
                                    //                                       12,
                                    //                                   vertical:
                                    //                                       10),
                                    //                           child: Row(
                                    //                             children: [
                                    //                               Expanded(
                                    //                                 child: Text(
                                    //                                   item,
                                    //                                   style: TextStyle(
                                    //                                       color: Colors
                                    //                                           .grey[700]),
                                    //                                 ),
                                    //                               ),
                                    //                               Icon(
                                    //                                 tempPickedItem ==
                                    //                                         item
                                    //                                     ? Icons
                                    //                                         .radio_button_checked
                                    //                                     : Icons
                                    //                                         .radio_button_off,
                                    //                                 color: Colors
                                    //                                         .grey[
                                    //                                     600],
                                    //                               ),
                                    //                             ],
                                    //                           ),
                                    //                         ),
                                    //                       ),
                                    //                     ],
                                    //                   );
                                    //                 },
                                    //               ),
                                    //               actionButton: MaterialButton(
                                    //                 height: 60,
                                    //                 shape: RoundedRectangleBorder(
                                    //                   borderRadius:
                                    //                       BorderRadius.only(
                                    //                     bottomLeft:
                                    //                         Radius.circular(10),
                                    //                     bottomRight:
                                    //                         Radius.circular(10),
                                    //                   ),
                                    //                 ),
                                    //                 minWidth: double.infinity,
                                    //                 color: Colors.blue[500],
                                    //                 onPressed: () {
                                    //                   setDialogState((){

                                    //                   });
                                    //                 },
                                    //                 child: Text(
                                    //                   'Save',
                                    //                   style: TextStyle(
                                    //                       color: Colors.white),
                                    //                 ),
                                    //               ),
                                    //             );
                                    //           },
                                    //         );
                                    //       },
                                    //     );
                                    //   }
                                    // },
                                    onSaveAction: () {
                                      Navigator.pop(context);
                                      CustomSnackBar.show(
                                        context: context,
                                        message: 'Status updated Successfully',
                                        color: Colors.green,
                                        icon: Icons.check_circle,
                                      );
                                    }));
                          },
                        );
                      },
                      child: CustomMechaniRequestCards(
                        mechanicName: transaction['mechanicName'],
                        status: transaction['status'],
                        date: transaction['date'],
                        time: transaction['time'],
                        phoneNo: transaction['phoneNo'].toString(),
                        place: transaction['place'],
                        services: transaction['services'],
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
