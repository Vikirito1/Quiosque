import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quiosque/app/modules/home/home_page.dart';
import 'package:quiosque/app/modules/splash/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static String route = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashController _controller = GetIt.I<SplashController>();

  @override
  void initState() {
    _controller.initializeDependencies().then((_) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomePage.route,
          (route) => false,
        );
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6FD03),
      body: Center(
        child: Image.asset('images/logo.png'),
      ),
    );
  }
}
