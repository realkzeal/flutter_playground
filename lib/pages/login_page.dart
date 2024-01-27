import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/Widgets/b_text_field.dart';
import 'package:flutter_playground/pages/login_otp_page.dart';
import 'package:toastification/toastification.dart';

import '../Widgets/Button.dart';
import '../utils/theme.dart';

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
  EmailOTP myAuth = EmailOTP();

  @override
  void initState() {
    super.initState();
    myAuth.setConfig(
        appEmail: "weric9793@gmail.com",
        appName: "Brinks OTP",
        userEmail: "eranmendez508@gmail.com",
        otpLength: 6,
        otpType: OTPType.digitsOnly);
  }

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
                            hint: "Username"
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
                            isPassword: true,
                            hint: 'Password' //
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
                            onPressed: () async {
                              if (loginFormKey.currentState!.validate()) {
                                if (_usernameCtrl.text.trim().toLowerCase() ==
                                        (user['username']?.toLowerCase() ??
                                            '') &&
                                    _passwordCtrl.text.trim() ==
                                        user['password'])  {
                                          await myAuth.sendOTP();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginOtpPage(
                                                auth: myAuth,
                                              )),
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
