import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_thursday/core/app_routes.dart';
import 'package:todo_c11_thursday/providers/app_auth_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(seconds: 3),
      () {
        navigate(context);
      },
    );
    return Image.asset(
      'assets/images/splash_background.png',
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.fill,
    );
  }

  void navigate(BuildContext context) async {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    if (authProvider.isLoggedInBefore()) {
      await authProvider.retrieveUserFromDatabase();
      Navigator.pushReplacementNamed(context, AppRoutes.homeRoute);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
    }
  }
}
