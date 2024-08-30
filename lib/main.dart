import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_c11_thursday/core/app_routes.dart';
import 'package:todo_c11_thursday/core/theme/app_theme.dart';
import 'package:todo_c11_thursday/firebase_options.dart';
import 'package:todo_c11_thursday/providers/app_auth_provider.dart';
import 'package:todo_c11_thursday/ui/auth/login/login_screen.dart';
import 'package:todo_c11_thursday/ui/auth/register/register_screen.dart';
import 'package:todo_c11_thursday/ui/home/home_screen.dart';
import 'package:todo_c11_thursday/ui/spalsh/spalsh_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider<AppAuthProvider>(
      create: (context) => AppAuthProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      onGenerateRoute: (settings) {
        print(settings.name);
        switch (settings.name) {
          case AppRoutes.homeRoute:
            {
              return MaterialPageRoute(
                builder: (context) => HomeScreen(),
              );
            }
          case AppRoutes.registerRoute:
            {
              return MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              );
            }
          case AppRoutes.loginRoute:
            {
              return MaterialPageRoute(
                builder: (context) => LoginScreen(),
              );
            }
          case AppRoutes.splashRoute:
            {
              return MaterialPageRoute(
                builder: (context) => SplashScreen(),
              );
            }
        }
      },
      initialRoute: AppRoutes.splashRoute,
    );
  }
}
