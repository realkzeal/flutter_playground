import 'package:flutter/material.dart';
import 'package:flutter_playground/boxes.dart';
import 'package:flutter_playground/hive_transaction.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/withdraw_data.dart';
import 'pages/SplashScreen.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<WithdrawData>(WithdrawData());
}

void main() async {
  setup();
  await Hive.initFlutter();
  Hive.registerAdapter(HiveTransactionAdapter());
  boxTransactions = await Hive.openBox<HiveTransaction>('transaction');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
