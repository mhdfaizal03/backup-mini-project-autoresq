import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mini_project_1/admin/view/screens/home/user_home_screen.dart';
import 'package:mini_project_1/main.dart';
import 'package:mini_project_1/utils/colors.dart';
import 'package:mini_project_1/utils/messages.dart';
import 'package:mini_project_1/utils/widgets.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int selectIndex = 0;
  List<String> tabs = ['Rejected', 'Completed'];

  // final List<Map<String, dynamic>> transactions = [
  //   {
  //     'name': 'John Doe',
  //     'date': 'April 2, 2025',
  //     'mechName': 'Johnson',
  //     'address': '4517 Washington Ave. Manchester, Kentucky 39495',
  //     'status': 'Mechanic Picked',
  //     'phone': '+91 1234567890',
  //     'countof_issues': 6,
  //   },
  //   {
  //     'name': 'John Dany',
  //     'date': 'April 2, 2025',
  //     'mechName': 'Bosco',
  //     'address': '4517 Washington Ave. Manchester, Kentucky 39495',
  //     'status': 'Completed',
  //     'phone': '+91 1234567890',
  //     'countof_issues': 6,
  //   },
  //   {
  //     'name': 'John Doe',
  //     'date': 'April 2, 2025',
  //     'mechName': 'Helsinki',
  //     'address': '4517 Washington Ave. Manchester, Kentucky 39495',
  //     'status': 'Requested',
  //     'mechnicStatus': 'No Mechanic Picked',
  //     'phone': '+91 1234567890',
  //     'countof_issues': 6,
  //   },
  //   {
  //     'name': 'John Doe',
  //     'date': 'April 2, 2025',
  //     'mechName': 'Luna',
  //     'address': '4517 Washington Ave. Manchester, Kentucky 39495',
  //     'status': 'Requested',
  //     'mechnicStatus': 'Requested',
  //     'phone': '+91 1234567890',
  //     'countof_issues': 6,
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            tabs.length,
            (index) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectIndex = index;
                      });
                    },
                    child: Container(
                      height: mq.height * 0.045,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(mq.width * 0.015),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 6,
                          ),
                        ],
                        color:
                            selectIndex == index ? primaryColor : Colors.white,
                      ),
                      child: Center(
                          child: Text(
                        tabs[index],
                        style: TextStyle(
                          color: selectIndex == index
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      )),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('mechanic_requests')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: customLoading());

            final requests = snapshot.data!.docs;

            final filtered = requests.where((doc) {
              final status = doc['status'];
              return selectIndex == 0
                  ? status == 'Requested'
                  : status == 'Completed' || status == 'Rejected';
            }).toList();

            return filtered.isEmpty
                ? Center(
                    child: Text(
                      'No ${tabs[selectIndex]} transactions found',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final req = filtered[index];

                      return CustomUserCards(
                        color: pickColor(req['status']),
                        date: timeFormatter(req['createdAt']),
                        address: req['location'],
                        issuescount: (req['specializations'] as List).length,
                        mechanicStatus: req['status'] == 'Requested'
                            ? 'No Mechanic Picked '
                            : req['mechName'],
                        onClickViewDetails: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                                child: AlertDialog(
                                  scrollable: true,
                                  insetPadding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  contentPadding: const EdgeInsets.all(10),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  content: StatefulBuilder(
                                    builder: (context, setDialogState) {
                                      final String location =
                                          req['location'] ?? 'N/A';
                                      final List<dynamic> specs =
                                          req['specializations'] ?? [];
                                      final String description =
                                          req['description'] ?? 'N/A';
                                      final String status = req['status'];
                                      final String requestedOn =
                                          timeFormatter(req['createdAt']);
                                      final String mechName =
                                          req['status'] == 'Requested'
                                              ? 'No one is take the work'
                                              : req['mechName'] ?? 'N/A';

                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Breakdown Location'),
                                          Text(
                                            location,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text('Issue'),
                                          Text(
                                            '${specs.length} Issues selected',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: primaryColor,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          const Text('Issue Description'),
                                          buildLabel(description),
                                          const SizedBox(height: 10),
                                          const Text('Assigned Mechanic'),
                                          buildLabel(status == 'Requested'
                                              ? 'No one has accepted the work'
                                              : 'Work Picked by $mechName'),
                                          const SizedBox(height: 10),
                                          const Text('Requested On'),
                                          buildLabel(requestedOn),
                                          const SizedBox(height: 10),
                                          const Text('Status'),
                                          Text(
                                            status == 'Requested'
                                                ? 'No Mechanic Picked'
                                                : status,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: pickColor(status),
                                            ),
                                          ),
                                          if (status == 'Requested') ...[
                                            const Text(
                                              '(Waiting for a mechanic to accept your request.)',
                                              style: TextStyle(
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ],
                                          const SizedBox(height: 20),
                                          MaterialButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            height: 50,
                                            minWidth: double.infinity,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            color: Colors.red,
                                            child: const Text(
                                              'Close',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
          },
        ),
        SizedBox(
          height: 80,
        )
      ],
    );
  }
}

String timeFormatter(dynamic data) {
  if (data != null) {
    try {
      return DateFormat('MMMM d, y').format(data.toDate());
    } catch (e) {
      return '';
    }
  }
  return '';
}
