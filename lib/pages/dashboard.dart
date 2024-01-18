import 'package:flutter/material.dart';
import 'package:flutter_playground/Widgets/Button.dart';
import 'package:flutter_playground/utils/helper.dart';
import 'package:flutter_playground/utils/theme.dart';
import 'package:jiffy/jiffy.dart';

import 'withdraw_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
          padding: const EdgeInsets.all(16.0),
          child: ListView(children: [
            const UserNameWidget(),
            const TransactionWidget(),
            const OverviewCard(),
            const DetailCard(
              header: "Saving Account",
              icon: Icons.account_balance_wallet_outlined,
              title: "Saving Account", subtitle: "\$12,000", ),
            const DetailCard(
              header: "Loan and lines of credit",
              icon: Icons.money,
              title: "Business and support loan", subtitle: "+\$5,500",
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
                    child: Text("Recent Transactions", style: headline3WhiteStyle,),
                  ),
                  const Divider(color: Colors.white,),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("BMT/SYB/S009-RCL", style: contentWhiteBoldStyle,),
                          Text("Dec 1, 2023", style: contentWhiteStyle,),
                          Text("Deposit", style: blueWhiteStyle,),
                        ]
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("\$6,500,000", style: contentWhiteBoldStyle,),
                          Text("Credit", style: contentWhiteStyle,),
                          ]
                      )
                    ],
                  )

                ],
              )
            )
          ]),
        ));
  }
}

class DetailCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String header;
  const DetailCard({
    super.key, required this.header,required this.icon, required this.title, this.subtitle
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Text(header, style: headline2Style,),
          Padding(
            padding: const EdgeInsets.only(top:16.0),
            child:  Row(
              children: [
                const CircleAvatar(
                    child: Icon(Icons.account_balance_wallet_outlined)),
                const SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: contentStyle,),
                    Text(subtitle ?? "", style: contentStyle,)
                  ]
                )
              ],
            ),
          )
        ]
      ),
    );
  }
}

class OverviewCard extends StatelessWidget {
  const OverviewCard({
    super.key,
  });

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
              Text("Last Login",style: white16BoldStyle,),
              Text(Jiffy.now().yMMMdjm,style: white12BoldStyle,),
              const SizedBox(height: 40,),
              const SizedBox(
                  height: 70,  width: 70, child: ProfilePicture()),
            ],
          ),
          const AccountOverview(),
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
  const AccountOverview({
    super.key,
  });

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
          "\$ 6,500,000",
          style: headline1WhiteStyle,
        ),
        const SizedBox(height: 40,),
        Text('IP Address', style: white16BoldStyle),
        Text('2.255.249.121', style: white16BoldStyle),
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
