import 'package:flutter/material.dart';
import 'package:mini_project_1/admin/view/auth/login_screen.dart';

class SplashIconScreen extends StatefulWidget {
  const SplashIconScreen({super.key});

  @override
  State<SplashIconScreen> createState() => _SplashIconScreenState();
}

class _SplashIconScreenState extends State<SplashIconScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    Future.delayed(const Duration(milliseconds: 1500), () {
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 1000),
              pageBuilder: (_, __, context) => const SplashInnerScreen()),
          (route) => true);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
            key: GlobalKey(),
            child: Image.asset(
              'assets/icons/tow.png',
              width: 204,
            )),
      ),
    ));
  }
}

class SplashInnerScreen extends StatefulWidget {
  const SplashInnerScreen({super.key});

  @override
  State<SplashInnerScreen> createState() => _SplashInnerScreenState();
}

class _SplashInnerScreenState extends State<SplashInnerScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 1500),
              pageBuilder: (_, __, context) => const AdminLoginScreen()),
          (route) => false);
    });
    super.initState();
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
                key: GlobalKey(),
                child: Image.asset(
                  'assets/icons/tow.png',
                  width: 55,
                )),
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
