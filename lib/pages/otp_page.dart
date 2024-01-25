import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/Widgets/b_text_field.dart';
import 'package:flutter_playground/pages/dashboard.dart';
import 'package:flutter_playground/utils/theme.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Widgets/button.dart';
import 'success_screen.dart';

class OtpPage extends StatefulWidget {
  final EmailOTP auth;
  const OtpPage({super.key, required this.auth});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _otpCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                "assets/images/brinks-logo-blue.png",
                height: 25,
              ),
              const ProfilePicture()
            ],
          ),
          actions: [
            GestureDetector(
              onTap: () {
                launchUrl(Uri.parse('mailto:weric9793@gmail.com'));
              },
              child: const CircleAvatar(child: Icon(Icons.support_agent)),
            )
          ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Text(
                  'Complete your transaction',
                  style: headline2Style,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Please enter the six digits OTP code sent to your email address associated with your account',
                  textAlign: TextAlign.center,
                  style: contentStyle,
                ),
                const SizedBox(
                  height: 16,
                ),
                BTextField(
                    textController: _otpCtrl,
                    prefixIcon: Icons.numbers,
                    hint: 'Enter OTP code'),
                const SizedBox(
                  height: 32,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Button(
                    text: 'Verify OTP code',
                    customButtonStyle: buttonBlueStyle,
                    textStyle: headline3WhiteStyle,
                    onPressed: () async {
                      final isValid =
                          await widget.auth.verifyOTP(otp: _otpCtrl.text);
                      if (isValid.runtimeType == bool && isValid == true) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const SuccessScreen()));
                      }
                    },
                  ),
                )
              ],
            )));
  }
}
