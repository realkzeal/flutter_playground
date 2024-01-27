import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_playground/boxes.dart';
import 'package:flutter_playground/hive_transaction.dart';
import 'package:flutter_playground/models/data_model.dart';
import 'package:flutter_playground/models/withdraw_data.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:uuid/uuid.dart';

String greet() {
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour >= 0 && hour < 12) {
    return 'Good Morning';
  } else if (hour >= 12 && hour < 18) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}

Future<DataModel> loadJson() async {
  String data = await rootBundle.loadString('lib/utils/data.json');

  Map<String, dynamic> jsonMap = json.decode(data);

  return DataModel.fromJson(jsonMap);
}

//format date to this format "Dec 1, 2023"
String formattedDate(DateTime date) {
  final inputFormat = DateFormat("yyyy-MM-dd HH:mm:ss.S");
  return Jiffy.parse(inputFormat.format(date)).yMMMMd;
}

String formatCurrency(String amount) {
  final formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');
  return formatter.format(double.parse(amount));
}

saveData(WithdrawData data) async {
  final uuid = Uuid();
  await boxTransactions.add(HiveTransaction(
      id: uuid.v4(),
      name: '${data.acctHolder} ${data.acctNumber} ${data.bankName}',
      date: DateTime.now(),
      amount: double.parse(data.amount ?? '0'),
      status: "PENDING",
      reference: "BMT/SYB/${generateCode()}",
      type: "DEBIT"));
}

//Generate 7 character code with hyphen e.g SOO9-RCL
String generateCode() {
  String code = "";
  for (int i = 0; i < 7; i++) {
    code += Random().nextInt(10).toString();
  }
  return code;
}
