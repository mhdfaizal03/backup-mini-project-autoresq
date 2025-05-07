import 'package:flutter/material.dart';
import 'package:mini_project_1/admin/view/auth/login_screen.dart';
import 'package:mini_project_1/admin/view/profile/terms_and_co.dart';
import 'package:mini_project_1/admin/view/screens/notification_page.dart';
import 'package:mini_project_1/common_screens/bottom_navbar_screen.dart';
import 'package:mini_project_1/common_screens/toggle_button_screen.dart';
import 'package:mini_project_1/main.dart';
import 'package:mini_project_1/mechanic/view/auth/create_account/professional_details_page.dart';
import 'package:mini_project_1/mechanic/view/auth/mechanic_login_page.dart';
import 'package:mini_project_1/mechanic/view/screens/Mechanic_navbar_page.dart';
import 'package:mini_project_1/common_screens/profile_details.dart';

class MechanicProfilePage extends StatefulWidget {
  const MechanicProfilePage({super.key});

  @override
  State<MechanicProfilePage> createState() => _MechanicProfilePageState();
}

class _MechanicProfilePageState extends State<MechanicProfilePage> {
  List<Map<String, dynamic>> profileData = [
    {
      'title': 'Mechanic Details',
      'leading': 'assets/nav_icons/person_unselected.png',
      'trialing': Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18,
      ),
      'page': (context) => ProfileDetails(
            name: 'No Name',
            email: 'No Email',
            profileUrl: '',
            phone: '',
            location: '',
          ),
      'route': true,
    },
    {
      'title': 'Professional Details',
      'leading': 'assets/nav_icons/professional_details.png',
      'trialing': Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18,
      ),
      'page': (context) => ProfessionalDetailsPage(),
      'route': true,
    },
    {
      'title': 'Notifications',
      'leading': 'assets/profile_icons/notification_profile.png',
      'trialing': Icon(
        Icons.arrow_forward_ios_rounded,
        size: 18,
      ),
      'page': (context) => MechanicNavbarPage(
            selectedIndex: 1,
          ),
      'route': false,
    },
    {
      'title': 'Terms and policy',
      'leading': 'assets/profile_icons/security_profile.png',
      'trialing': Icon(
        Icons.error,
        size: 0,
      ),
      'page': (context) => TermsAndCo(),
      'route': true,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Hero(
            tag: 'profile',
            child: CircleAvatar(
              radius: mq.width * 0.15,
              backgroundImage: NetworkImage(
                'https://cdn.prod.website-files.com/62d84e447b4f9e7263d31e94/6399a4d27711a5ad2c9bf5cd_ben-sweet-2LowviVHZ-E-unsplash-1.jpeg',
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Victoria David',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'mechnic123@gmail.com',
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          children: List.generate(
            profileData.length,
            (index) {
              return InkWell(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: profileData[index]['page']),
                    (route) => profileData[index]['route'],
                  );
                },
                child: ProfileCards(
                  profileData[index]['trialing'],
                  image: profileData[index]['leading'],
                  title: profileData[index]['title'],
                ),
              );
            },
          ),
        ),
        SizedBox(
          height: 50,
        ),
        InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MechanicLoginPage()),
              (route) => false,
            );
          },
          child: Container(
            height: mq.height * 0.070,
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(mq.width * 0.025),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 0.5,
                  blurRadius: 6,
                ),
              ],
              color: Colors.white,
            ),
            child: Center(
              child: ListTile(
                title: Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                leading: Image.asset(
                  'assets/icons/logout.png',
                  width: 30,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileCards extends StatelessWidget {
  String title;
  String image;
  Widget trialingIcon;

  ProfileCards(
    this.trialingIcon, {
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: mq.height * 0.068,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(mq.width * 0.025),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 0.5,
            blurRadius: 6,
          ),
        ],
        color: Colors.white,
      ),
      child: Center(
        child: ListTile(
            title: Text(title),
            leading: Image.asset(
              image,
              width: 30,
            ),
            trailing: trialingIcon),
      ),
    );
  }
}
