import 'dart:async';

import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/models/withdraw_data.dart';
import 'package:flutter_playground/pages/otp_page.dart';
import 'package:flutter_playground/utils/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/helper.dart';

class Processing extends StatefulWidget {
  final WithdrawData data;
  const Processing({super.key, required this.data});

  @override
  State<Processing> createState() => _ProcessingState();
}

class _ProcessingState extends State<Processing> {
  EmailOTP myAuth = EmailOTP();
  List<String> getTextList() {
    String recipientInfo =
        '${widget.data.acctHolder} | ${widget.data.acctNumber} | ${widget.data.amount} | ${widget.data.bankName}';

    textList = [
      'Transaction in progress',
      '*** $recipientInfo *** ',
      'TRANSACTION IN PROGRESS \n*** $recipientInfo ***',
      'ACCOUNT DETAIL VERIFIED \n*** $recipientInfo ***',
      'YOUR TRANSFER DATA IS BEING PROCESS \n*** $recipientInfo *** ',
      'TRANSFER DATA PROCESSED ::: CONTACTING BENEFICIARY BANK($recipientInfo)',
      '12%......OF TRANSFER DATA COMPLETED \n*** $recipientInfo ***',
      '19%......OF TRANSFER DATA COMPLETED',
      'PLEASE WAIT WHILE YOUR TRANSACTION IS PROCESSING...',
      '35%......OF TRANSFER DATA COMPLETED \n*** $recipientInfo *** ',
      '42%......PROCESSING ALL CHARGES',
      '50%......PROCESSING ADMINISTRATIVE CHARGES',
      'ADMINISTRATIVE CHARGES PROCESSED SUCCESSFULLY',
      'TERMINATING TRANSFER \n*** $recipientInfo ***',
      '60%......TRANSFER TERMINATED *** APPROVAL CODE *** NEEDED TO PROCEED',
    ];

    return textList;
  }

  int currentIndex = 0;
  late Timer timer;
  List<String> textList = [];
  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    textList = getTextList();
    myAuth.setConfig(
        appEmail: "weric9793@gmail.com",
        appName: "Brinks OTP",
        userEmail: "eranmendez508@gmail.com",
        otpLength: 6,
        otpType: OTPType.digitsOnly);

    timer = Timer.periodic(const Duration(seconds: 4), (timer) async {
      final pref = await _preferences;
      updateList();
      // cancel timer if currentIndex == textList.length -1
      if (currentIndex == textList.length - 1) {
        saveData(widget.data);
        timer.cancel();
        var balance = pref.getDouble('accountBalance');

        if (balance != null) {
          balance = balance - double.parse(widget.data.amount ?? '0.00');
          pref.setDouble('accountBalance', balance);
        }

        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => OtpPage(
                  auth: myAuth,
                )));
        await myAuth.sendOTP();
      }
    });
  }

  void updateList() {
    setState(() {
      currentIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/images/brinks-logo-blue.png",
            height: 25,
          ),
          Container(
            width: 150,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.grey.withOpacity(0.6)),
            child: const SpinKitHourGlass(size: 100, color: Colors.blue),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            textList[currentIndex],
            textAlign: TextAlign.center,
            style: contentStyle,
          ),
          DisclosureWidget()
        ],
      ),
    ));
  }
}

class DisclosureWidget extends StatelessWidget {
  const DisclosureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Colors.grey.withOpacity(0.4)),
      child: Text(
        "All electronic fund transfers to or from your accounts at Brents "
        "are governed by the Electronic Fund Transfer Disclosure provided to you "
        "when you established your account or when your requested other"
        "electronic fund transfer services",
        textAlign: TextAlign.center,
        style: contentWhiteBoldStyle,
      ),
    );
  }
}
