import 'package:flutter/material.dart';
import 'package:quiosque/app/modules/home/home_page.dart';
import 'package:quiosque/app/modules/splash/splash_screen.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialRoute: SplashScreen.route,
      routes: {
        SplashScreen.route: (context) => const SplashScreen(),
        HomePage.route: (context) => const HomePage(),
      },
    );
  }
}
