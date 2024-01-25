import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'models/withdraw_data.dart';
import 'pages/SplashScreen.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<WithdrawData>(WithdrawData());

}

void main() {
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
