import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project_1/user/view/auth/user_login.dart';
import 'package:mini_project_1/user/view/screens/user_navbar_page.dart';

class SplashIconScreen extends StatefulWidget {
  const SplashIconScreen({super.key});

  @override
  State<SplashIconScreen> createState() => _SplashIconScreenState();
}

class _SplashIconScreenState extends State<SplashIconScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (_, __, ___) => const SplashInnerScreen(),
        ),
        (route) => false,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Hero(
            tag: 'tow',
            child: Image.asset(
              'assets/icons/tow.png',
              width: 204,
            ),
          ),
        ),
      ),
    );
  }
}

class SplashInnerScreen extends StatefulWidget {
  const SplashInnerScreen({super.key});

  @override
  State<SplashInnerScreen> createState() => _SplashInnerScreenState();
}

class _SplashInnerScreenState extends State<SplashInnerScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _navigateUser();
  }

  void _navigateUser() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    try {
      final user = _auth.currentUser;

      if (user != null) {
        // Navigate to home
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1500),
            pageBuilder: (_, __, ___) => UserNavPage(),
          ),
          (route) => false,
        );
      } else {
        // Navigate to login
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1500),
            pageBuilder: (_, __, ___) => const UserLogin(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      // Handle error if needed
      debugPrint('Error during auth check: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'tow',
              child: Image.asset(
                'assets/icons/tow.png',
                width: 55,
              ),
            ),
            const SizedBox(width: 10),
            Image.asset(
              'assets/icons/AutoResQ.png',
              width: 190,
            ),
          ],
        ),
      ),
    );
  }
}
