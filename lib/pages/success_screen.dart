import 'package:flutter/material.dart';
import 'package:flutter_playground/pages/dashboard.dart';
import 'package:flutter_playground/pages/processing.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Widgets/button.dart';
import '../utils/theme.dart';
import 'review.dart';
import 'withdraw_screen.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: ListView(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              child: Icon(
                Icons.done,
                size: 40,
                color: Colors.white,
                weight: 20,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              'Transaction Successful',
              textAlign: TextAlign.center,
              style: headline1Style,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
                'You are have successfully transfer \$${withdrawDetail.amount ?? 0} to ${withdrawDetail.acctHolder}',
                textAlign: TextAlign.center,
                style: headline3Style),
            Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white70,
                border: Border.all(color: primaryColor),
              ),
              child: Column(
                children: [
                  ReviewCard(
                    title: 'Account Holder',
                    value: withdrawDetail.acctHolder ?? "",
                  ),
                  Divider(),
                  ReviewCard(
                    title: 'Bank Name',
                    value: withdrawDetail.bankName ?? "",
                  ),
                  const Divider(),
                  ReviewCard(
                      title: 'Account Number',
                      value: withdrawDetail.acctNumber ?? ""),
                  const Divider(),
                  ReviewCard(
                    title: 'Amount',
                    value: '\$ ${withdrawDetail.amount ?? "0.00"}',
                  ),
                  Divider(),
                  ReviewCard(
                    title: 'Description',
                    value: withdrawDetail.description ?? "",
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Button(
                  text: 'New Transaction',
                  customButtonStyle: buttonBlueStyle,
                  textStyle: headline3WhiteStyle,
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const WithdrawScreen()),
                    );
                  },
                ),
                Button(
                    text: 'Back To Home',
                    customButtonStyle: buttonBlueStyle,
                    textStyle: headline3WhiteStyle,
                    onPressed: () async {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const Dashboard()),
                        (route) => false,
                      );
                    }),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () async {
                launchUrl(Uri.parse('mailto:weric9793@gmail.com'));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                      backgroundColor: logoColor, child: Icon(Icons.email)),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Contact Support at weric9793@gmail.com")
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const DisclosureWidget()
          ],
        ),
      ),
    );
  }
}
