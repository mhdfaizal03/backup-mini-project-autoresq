import 'package:flutter/material.dart';
import 'package:mini_project_1/user/models/model/create_request_model.dart';
import 'package:mini_project_1/user/models/services/firebase_auth_services.dart';
import 'package:mini_project_1/utils/colors.dart';
import 'package:mini_project_1/utils/messages.dart';
import 'package:mini_project_1/utils/widgets.dart';

class UserCreateRequestsPage extends StatefulWidget {
  const UserCreateRequestsPage({super.key});

  @override
  State<UserCreateRequestsPage> createState() => _UserCreateRequestsPageState();
}

class _UserCreateRequestsPageState extends State<UserCreateRequestsPage> {
  final List<String> specifications = [
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

  final _firebaseServices = FirebaseFirestoreServices();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    if (selectedItems.isEmpty) {
      CustomSnackBar.show(
        context: context,
        message: 'Please select at least one specialization',
        color: Colors.red,
        icon: Icons.error,
      );
      return;
    }

    final request = UserCreateRequestModel(
      userName: 'John',
      userEmail: 'john221@gmail.com',
      phone: phoneController.text.trim(),
      location: locationController.text.trim(),
      specializations: selectedItems,
      description: descriptionController.text.trim(),
    );

    try {
      showLoadingDialog(context);
      await _firebaseServices.submitMechanicRequest(request);
      Navigator.pop(context);
      CustomSnackBar.show(
        context: context,
        message: 'Request submitted successfully!',
        color: Colors.green,
        icon: Icons.check_circle,
      );
    } catch (e) {
      CustomSnackBar.show(
        context: context,
        message: 'Failed to submit request: ${e.toString()}',
        color: Colors.red,
        icon: Icons.error_outline,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: MaterialButton(
          height: 50,
          color: primaryColor,
          minWidth: double.infinity,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: submitRequest,
          child: const Text('Book Now', style: TextStyle(color: Colors.white)),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomBackButton(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      CircleAvatar(
                          radius: 45, backgroundColor: Colors.grey[200]),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('John',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('john221@gmail.com'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  buildLabel('Mobile Number'),
                  const SizedBox(height: 5),
                  CustomTextField(
                    controller: phoneController,
                    text: 'Enter your phone no here',
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return 'Please enter your phone number';
                      if (val.length < 10) return 'Enter a valid phone number';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  buildLabel('Your location'),
                  const SizedBox(height: 5),
                  CustomTextField(
                    controller: locationController,
                    maxLines: 2,
                    text:
                        'Enter the location where your vehicle is stuck or broken down.',
                    validator: (val) {
                      if (val == null || val.isEmpty)
                        return 'Please enter your location';
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  buildLabel('Issue Type'),
                  const SizedBox(height: 5),
                  CustomTextField(
                    readOnly: true,
                    controller: TextEditingController(),
                    text: selectedItems.isEmpty
                        ? 'Select Specializations'
                        : '${selectedItems.length} Specializations selected',
                    validator: (_) => null,
                    suffix: IconButton(
                      icon: const Icon(Icons.keyboard_arrow_down_rounded),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, localSetState) {
                                return CustomSpecificationsDialog(
                                  headerItems: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 18),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Select Specializations',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  context: context,
                                  children: List.generate(specifications.length,
                                      (index) {
                                    final item = specifications[index];
                                    final isSelected =
                                        selectedItems.contains(item);

                                    return Column(
                                      children: [
                                        const Divider(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          child: InkWell(
                                            onTap: () {
                                              localSetState(() {
                                                if (isSelected) {
                                                  selectedItems.remove(item);
                                                } else {
                                                  selectedItems.add(item);
                                                }
                                              });

                                              setState(() {});
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 5.0),
                                              child: Row(
                                                children: [
                                                  Expanded(child: Text(item)),
                                                  Icon(isSelected
                                                      ? Icons.radio_button_on
                                                      : Icons.radio_button_off),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                  actionButton: MaterialButton(
                                    height: 60,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      ),
                                    ),
                                    minWidth: double.infinity,
                                    color: Colors.blue[500],
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Save',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildLabel('Additional Details (Optional)'),
                  const SizedBox(height: 5),
                  CustomTextField(
                    controller: descriptionController,
                    maxLines: 5,
                    text: 'Describe the issue in detail',
                    validator: (_) => null,
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
