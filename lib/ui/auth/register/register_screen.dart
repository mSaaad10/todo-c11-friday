import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_c11_thursday/core/app_routes.dart';
import 'package:todo_c11_thursday/core/utils/email_validation.dart';
import 'package:todo_c11_thursday/ui/widgets/custom_text_form_field.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController passwordConfirmationController =
      TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.blue.shade900,
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset('assets/images/auth_logo.svg'),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Full Name',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                CustomTextFormField(
                  controller: fullNameController,
                  hint: 'Full Name',
                  keyboardType: TextInputType.name,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter Full Name';
                    }
                    if (input is int) {
                      return 'Sorry, Invalid input';
                    }
                    return null;
                  },
                ),
                Text(
                  'User Name',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                CustomTextFormField(
                  controller: userNameController,
                  hint: 'User Name',
                  keyboardType: TextInputType.name,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz, enter User Name';
                    }
                    return null;
                  },
                ),
                Text(
                  'E-mail',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                CustomTextFormField(
                  controller: emailController,
                  hint: 'E-mail Address',
                  keyboardType: TextInputType.emailAddress,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz enter e-mail address';
                    }
                    if (!isValidEmail(input)) {
                      return 'Email bad format';
                    }
                    return null;
                  },
                ),
                Text(
                  'Password',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                CustomTextFormField(
                  controller: passwordController,
                  hint: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                  isSecureText: true,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz enter password';
                    }
                    if (input.length < 6) {
                      return 'Sorry, Password should be at least 6 chars';
                    }
                    return null;
                  },
                ),
                Text(
                  'Confirm Password',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                CustomTextFormField(
                  controller: passwordConfirmationController,
                  hint: 're-password',
                  keyboardType: TextInputType.visiblePassword,
                  isSecureText: true,
                  validator: (input) {
                    if (input == null || input.trim().isEmpty) {
                      return 'Plz enter password';
                    }
                    if (input != passwordController.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: () {
                      register(emailController.text, passwordController.text);
                    },
                    child: Text('Register')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    TextButton(
                        style: TextButton.styleFrom(
                            //ToDo
                            ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.loginRoute);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void register(String email, String password) async {
    if (formKey.currentState?.validate() == false) {
      return;
    }

    // create account register user

    try {
      var userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print('userId: ${userCredential.user?.uid}');
      Navigator.pushReplacementNamed(context, AppRoutes.loginRoute);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
