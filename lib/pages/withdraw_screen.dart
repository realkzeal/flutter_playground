import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_playground/models/institution.dart';
import 'package:flutter_playground/pages/review.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Widgets/Button.dart';
import '../Widgets/b_text_field.dart';
import '../main.dart';
import '../models/withdraw_data.dart';
import '../utils/helper.dart';
import '../utils/theme.dart';
import 'dashboard.dart';

WithdrawData withdrawDetail = getIt<WithdrawData>();

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TextEditingController _acctHolderCtrl = TextEditingController();
  TextEditingController _bankNameCtrl = TextEditingController();
  final TextEditingController _amountCtrl = TextEditingController();
  final TextEditingController _acctNumberCtrl = TextEditingController();
  final TextEditingController _descriptionCtrl = TextEditingController();

  bool _isLoading = false;
  Timer? _debounceTimer;

  // Institution _selectedOption = Institution();

  List<Institution> _banks = [];

  @override
  initState() {
    super.initState();
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
                    Autocomplete<Institution>(
                      displayStringForOption: (Institution option) =>
                          option.name,
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text.isEmpty) {
                          return const Iterable<Institution>.empty();
                        }

                        // Debouncing: Wait for 300 milliseconds before making the API call
                        _debounceTimer?.cancel();
                        _debounceTimer =
                            Timer(Duration(milliseconds: 300), () async {
                          await fetchBanks(name: textEditingValue.text);
                        });

                        // Show loading indicator while waiting for the API response
                        // if (_isLoading) {
                        //   return [LoadingInstitution()];
                        // }

                        return _banks.where((Institution option) {
                          return option.name
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase());
                        });
                      },
                      fieldViewBuilder: (context, textEditingController,
                          focusNode, onFieldSubmitted) {
                        _bankNameCtrl = textEditingController;
                        return BTextField(
                          textController: textEditingController,
                          prefixIcon: Icons.account_balance,
                          focusNode: focusNode,
                          hint: 'Bank Name',
                        );
                      },
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
                          if (withdrawFormKey.currentState!.validate()) {
                            final withdrawData = WithdrawData(
                              bankName: _bankNameCtrl.text,
                              acctNumber: _acctNumberCtrl.text,
                              acctHolder: _acctHolderCtrl.text,
                              amount: _amountCtrl.text,
                              description: _descriptionCtrl.text,
                            );

                            withdrawDetail = withdrawData;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    Review(review: withdrawData)));
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

  Future<List<Institution>> fetchBanks({required String name}) async {
    const String plaidClientId = "65a298a7f70cf3001b2f8ad3";
    const String plaidSecret = "cfd683797b9bed9ffe3a9371d8a682";

    final Map<String, dynamic> requestBody = {
      'client_id': plaidClientId,
      'secret': plaidSecret,
      "query": name,
      // 'count': 100, // Number of institutions to retrieve
      'country_codes': ['US'],
      // 'offset': 0,
    };

    try {
      var url = Uri.https("sandbox.plaid.com", "/institutions/search");
      final response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(requestBody));
      var decodeResponse = jsonDecode(response.body);

      setState(() {
        _banks = List<Institution>.from(decodeResponse['institutions']
            ?.map((x) => Institution.fromJson(x)));
      });
      return _banks;
    } catch (e) {
      Logger().e('$e');
      return [];
    }
  }
}

class LoadingInstitution extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const ListTile(
      title: Text('Loading...'),
      leading: CircularProgressIndicator(),
    );
  }
}
