import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_c11_thursday/core/utils/email_validation.dart';
import 'package:todo_c11_thursday/ui/widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: () {
                      login();
                    },
                    child: Text('Login'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState?.validate() == false) {
      return;
    }

    // create account
  }
}
