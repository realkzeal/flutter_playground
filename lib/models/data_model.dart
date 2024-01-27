import 'transaction.dart';

class DataModel {
  List<Transaction> transactionList;

  DataModel({this.transactionList = const []});

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        transactionList: List<Transaction>.from(
            json['transactions'].map((x) => Transaction.fromTransaction(x))),
      );

  toJson() => {
        'transactions': transactionList.map((x) => x.toJson()).toList(),
      };
}
