import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/models/withdraw_data.dart';
import 'package:flutter_playground/utils/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Widgets/Button.dart';
import 'dashboard.dart';
import 'processing.dart';

class Review extends StatefulWidget {
  final WithdrawData review;
  const Review({super.key, required this.review});

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {

  @override
  void initState() {
    super.initState();
    
  }

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
            Text(
              'Review Transaction',
              textAlign: TextAlign.center,
              style: headline1Style,
            ),
            const SizedBox(
              height: 15,
            ),
            Text('Kindly review this transaction before proceeding',
                textAlign: TextAlign.center, style: headline3Style),
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
                    value: widget.review.acctHolder ?? "",
                  ),
                  Divider(),
                  ReviewCard(
                    title: 'Bank Name',
                    value: widget.review.bankName ?? "",
                  ),
                  const Divider(),
                  ReviewCard(
                      title: 'Account Number',
                      value: widget.review.acctNumber ?? ""),
                  const Divider(),
                  ReviewCard(
                    title: 'Amount',
                    value: '\$ ${widget.review.amount ?? "0.00"}',
                  ),
                  Divider(),
                  ReviewCard(
                    title: 'Description',
                    value: widget.review.description ?? "",
                  )
                ],
              ),
            ),
            Container(
                padding: const EdgeInsets.only(top: 30),
                child: Button(
                  text: 'Continue',
                  customButtonStyle: buttonBlueStyle,
                  textStyle: headline3WhiteStyle,
                  onPressed: () async {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) =>
                              Processing(data: widget.review)),
                    );
                  },
                ))
          ],
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String title;
  final String value;
  const ReviewCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: headline3Style),
          Text(
            value,
            style: contentStyle,
          )
        ],
      ),
    );
  }
}
