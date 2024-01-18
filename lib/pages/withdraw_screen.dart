import 'package:flutter/material.dart';
import 'package:flutter_playground/pages/review.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:rules/rules.dart';

import '../Widgets/Button.dart';
import '../Widgets/b_text_field.dart';
import '../models/withdraw_data.dart';
import '../utils/theme.dart';
import 'dashboard.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _acctHolderCtrl = TextEditingController();
  final TextEditingController _bankNameCtrl = TextEditingController();
  final TextEditingController _amountCtrl = TextEditingController();
  final TextEditingController _acctNumberCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();

  final _configuration =
    LinkTokenConfiguration(token: "link-sandbox-4283881e-6616-40c4-a09f-9f5fa1a79dab",);
  @override
  initState() {
    super.initState();
    fetchBank();
  }
  final withdrawFormKey = GlobalKey<FormState>();
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
        child: ListView(
          children: [
            Form(
                key: withdrawFormKey,
                child: Column(
                  children: [
                    Text(
                      'Online Banking Transfer',
                      textAlign: TextAlign.center,
                      style: headline3Style,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BTextField(
                      textController: _bankNameCtrl,
                      prefixIcon: Icons.account_balance,
                      hint: 'Bank Name',
                      // validator: Rule(_bankNameCtrl.text,
                      //     name: 'Bank Name',
                      //     isRequired: true,
                      //     isAlphaSpace: true),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BTextField(
                        textController: _acctNumberCtrl,
                        prefixIcon: Icons.credit_card,
                        hint: 'Account Number',
                        // validator: Rule(
                        //   _acctNumberCtrl.text,
                        //   name: 'Account Number',
                        //   isRequired: true,
                        //   isNumeric: true,
                        // )
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BTextField(
                      textController: _acctHolderCtrl,
                      prefixIcon: Icons.person,
                      hint: 'Account Holder',
                      // validator: Rule(
                      //   _acctHolderCtrl.text,
                      //   name: 'Account Holder',
                      //   isRequired: true,
                      //   isAlphaSpace: true,
                      // ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    BTextField(
                      textController: _amountCtrl,
                      prefixIcon: Icons.monetization_on_outlined,
                      hint: 'Amount',
                      // validator: Rule(
                      //   _amountCtrl.text,
                      //   name: 'Amount',
                      //   isRequired: true,
                      //   isNumeric: true,
                      // )
                    ),
                    const SizedBox(height: 15),
                    BTextField(
                      textController: _descriptionCtrl,
                      prefixIcon: Icons.note,
                      hint: 'Description',
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      height: 70,
                      child: Button(
                        text: 'Withdraw',
                        onPressed: () {
                          if(withdrawFormKey.currentState!.validate()){
                            final withdrawData = WithdrawData(
                              bankName: _bankNameCtrl.text,
                              acctNumber: _acctNumberCtrl.text,
                              acctHolder: _acctHolderCtrl.text,
                              amount: _amountCtrl.text,
                              description: _descriptionCtrl.text,
                            );

                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => Review(review: withdrawData)));
                          }

                        },
                        customButtonStyle: buttonBlueStyle,
                        textStyle: buttonWhiteTextStyle24,
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Future<void> fetchBank() async {

  }
}
