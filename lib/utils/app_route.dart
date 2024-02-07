import 'package:flutter/cupertino.dart';

import '../view/screen/home/home_screen.dart';
import '../view/screen/login/login_screen.dart';
import '../view/screen/register/register_page.dart';
import '../view/screen/splash/splash_screen.dart';

Route onGenerateRoute(RouteSettings settings) {
  Route page = CupertinoPageRoute(
    builder: (context) => const SplashScreen(),
  );
  switch (settings.name) {
    case "/splash":
      page = CupertinoPageRoute(
        builder: (context) => const SplashScreen(),
      );
      break;
    case "/login":
      page = CupertinoPageRoute(
        builder: (context) => const LoginScreen(),
      );
      break;
    case "/Home":
      page = CupertinoPageRoute(
        builder: (context) => const HomeScreen(),
      );
      break;
    case "/register":
      page = CupertinoPageRoute(
        builder: (context) => const RegisterScreen(),
      );
      break;
  }
return page;
}