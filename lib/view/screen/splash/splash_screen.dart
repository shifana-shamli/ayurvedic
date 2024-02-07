import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/app_constant.dart';
import '../../../utils/app_sp.dart';
import '../home/home_screen.dart';
import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future isLogged = SharedPrefrence().getIsLogged();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      bool val = await  SharedPrefrence().getIsLogged();
      if (val) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImg),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset(
            logo,
            width: 200,
            height: 200,
          ),

        )
      )
    );
  }
}
