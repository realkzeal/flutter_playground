import 'package:flutter/material.dart';
import 'package:flutter_playground/Widgets/Button.dart';
import 'package:flutter_playground/boxes.dart';
import 'package:flutter_playground/models/transaction.dart';
import 'package:flutter_playground/utils/helper.dart';
import 'package:flutter_playground/utils/theme.dart';
import 'package:jiffy/jiffy.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../hive_transaction.dart';
import 'withdraw_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  double? accountBalance;
  List<Transaction> transactionList = [];

  List<Transaction> getTransactionList() {
    for (HiveTransaction transaction in boxTransactions.values) {
      transactionList.add(Transaction(
        id: transaction.id,
        name: transaction.name,
        date: transaction.date,
        type: transaction.type,
        amount: transaction.amount,
        status: transaction.status,
        reference: transaction.reference,
      ));
    }
    return transactionList;
  }

  initMethod() async {
    final SharedPreferences pref = await _prefs;
    if (pref.getDouble('accountBalance') == null) {
      pref.setDouble('accountBalance', 6500000);
    }

    if (boxTransactions.isEmpty) {
      final uuid = Uuid();
      final response = await boxTransactions.add(HiveTransaction(
          id: uuid.v4(),
          date: DateTime.parse("2024-01-14 06:35:09.782288"),
          amount: 6500000,
          status: "COMPLETE",
          reference: "BMT/SYB/SOO9-RCL",
          type: "DEPOSIT"));
    }

    final transactions = await getTransactionList();

    setState(() {
      transactionList = transactions ?? [];
      accountBalance = pref.getDouble('accountBalance');
    });
  }

  @override
  void initState() {
    super.initState();
    initMethod();
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
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: [
            const UserNameWidget(),
            const TransactionWidget(),
            const OverviewCard(),
            const DetailCard(
              header: "Saving Account",
              icon: Icons.account_balance_wallet_outlined,
              title: "Saving Account",
              subtitle: "\$12,000",
            ),
            const DetailCard(
              header: "Loan and lines of credit",
              icon: Icons.money,
              title: "Business and support loan",
              subtitle: "+\$5,500",
            ),
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        "Recent Transactions",
                        style: headline3WhiteStyle,
                      ),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: List.generate(
                          transactionList.length,
                          (index) => Column(
                                children: [
                                  TransactionDetailCard(
                                      transaction: transactionList[index]),
                                  const Divider(color: Colors.white)
                                ],
                              )),
                    )
                  ],
                ))
          ]),
        ));
  }
}

class TransactionDetailCard extends StatelessWidget {
  final Transaction transaction;
  const TransactionDetailCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                transaction.reference,
                style: contentWhiteBoldStyle,
              ),
              Text(
                formattedDate(transaction.date ?? DateTime.now()),
                style: contentWhiteStyle,
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: const BoxDecoration(color: Colors.white),
                child: Text(
                  transaction.status,
                  style: blueWhiteStyle,
                ),
              ),
            ]),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                formatCurrency(transaction.amount.toString()),
                style: contentWhiteBoldStyle,
              ),
              Text(
                transaction.type,
                style: contentWhiteStyle,
              ),
            ])
      ],
    );
  }
}

class DetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String header;
  const DetailCard(
      {super.key,
      required this.header,
      required this.icon,
      required this.title,
      this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          header,
          style: headline2Style,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Row(
            children: [
              const CircleAvatar(
                  child: Icon(Icons.account_balance_wallet_outlined)),
              const SizedBox(
                width: 15,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  title,
                  style: contentStyle,
                ),
                Text(
                  subtitle ?? "",
                  style: contentStyle,
                )
              ])
            ],
          ),
        )
      ]),
    );
  }
}

class OverviewCard extends StatefulWidget {
  const OverviewCard({
    super.key,
  });

  @override
  State<OverviewCard> createState() => _OverviewCardState();
}

class _OverviewCardState extends State<OverviewCard> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  double accountBalance = 0;

  Future<void> _fetchAccountBalance() async {
    final SharedPreferences pref = await _prefs;
    setState(() {
      accountBalance = pref.getDouble("accountBalance") ?? 6500000;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchAccountBalance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Last Login",
                style: white16BoldStyle,
              ),
              Text(
                Jiffy.now().yMMMdjm,
                style: white12BoldStyle,
              ),
              const SizedBox(
                height: 40,
              ),
              const SizedBox(height: 70, width: 70, child: ProfilePicture()),
            ],
          ),
          AccountOverview(amount: accountBalance.toString()),
        ],
      ),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.asset(
          "assets/images/91.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class AccountOverview extends StatelessWidget {
  final String amount;

  AccountOverview({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Account Balance",
          style: white16BoldStyle,
        ),
        Text(
          formatCurrency(amount),
          style: headline1WhiteStyle,
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }
}

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Row(
        children: [
          Button(
              text: 'Deposit',
              textStyle: buttonWhiteTextStyle24,
              customButtonStyle: buttonGreen16Style),
          const SizedBox(
            width: 15,
          ),
          Button(
            text: 'Withdraw',
            textStyle: buttonWhiteTextStyle24,
            customButtonStyle: buttonGreen16Style,
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const WithdrawScreen()));
            },
          ),
        ],
      ),
    );
  }
}

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(greet(), style: black16BoldStyle),
        Text("Eran Mendez", style: headline1Style),
      ])
    ]);
  }
}
