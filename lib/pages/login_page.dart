import 'package:flutter/material.dart';
import 'package:flutter_playground/Widgets/b_text_field.dart';
import 'package:rules/rules.dart';
import 'package:toastification/toastification.dart';
import '../Widgets/Button.dart';
import '../utils/theme.dart';
import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameCtrl = TextEditingController();
  final loginFormKey = GlobalKey<FormState>();
  final TextEditingController _passwordCtrl = TextEditingController();

  final user = {"username": "eransarah01", "password": "Joygiver02#"};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: logoColor,
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  )),
              padding: const EdgeInsets.all(50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/brinks-logo-blue.png",
                    height: 25,
                  ),
                  Form(
                    key: loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BTextField(
                          textController: _usernameCtrl,
                          prefixIcon: Icons.email,
                          // validator: Rule(
                          //   _usernameCtrl.text,
                          //   name: "Username",
                          //   isRequired: true,
                          // ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        BTextField(
                          textController: _passwordCtrl,
                          prefixIcon: Icons.lock,
                          isObscure: true,
                          validator: (value) {
                            final rule = Rule(
                              value,
                                name: "Password", isRequired: true, minLength: 8);
                            if(rule.hasError) {
                              return rule.error;
                            }
                            return null;
                          }
                          //
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Button(
                            text: 'Login',
                            customButtonStyle: buttonBlueStyle,
                            textStyle: buttonWhiteTextStyle24,
                            onPressed: () {
                              if (loginFormKey.currentState!.validate()) {
                                if (_usernameCtrl.text == user['username'] &&
                                    _passwordCtrl.text == user['password']) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Dashboard()),
                                      (route) => false);
                                } else {
                                  toastification.show(
                                    context: context,
                                    type: ToastificationType.error,
                                    style: ToastificationStyle.fillColored,
                                    title: const Text(
                                        'Username or password is incorrect'),
                                    autoCloseDuration:
                                        const Duration(seconds: 5),
                                  );
                                }
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
