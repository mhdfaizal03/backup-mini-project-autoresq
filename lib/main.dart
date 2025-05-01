import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_project_1/admin/profile/mechanic_request_detailspage.dart';
import 'package:mini_project_1/admin/view/auth/login_screen.dart';
import 'package:mini_project_1/admin/view/screens/wallet/wallet_tab.dart';
import 'package:mini_project_1/common_screens/bottom_navbar_screen.dart';
import 'package:mini_project_1/common_screens/splash_screen.dart';
import 'package:mini_project_1/common_screens/toggle_button_screen.dart';
import 'package:mini_project_1/mechanic/view/auth/mechanic_login_page.dart';
import 'package:mini_project_1/mechanic/view/screens/Mechanic_Navbar_Page.dart';

late Size mq;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(
          fontFamily: 'Poppins',
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              enableFeedback: true,
              elevation: 10,
              backgroundColor: Colors.white),
          appBarTheme: AppBarTheme(backgroundColor: Colors.transparent)),
      home: MechanicNavbarPage(),
      // home: SplashIconScreen(),
      // home: ToggleButtonScreen(),
    );
  }
}
