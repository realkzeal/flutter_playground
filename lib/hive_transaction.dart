import 'package:hive/hive.dart';


part 'hive_transaction.g.dart';

@HiveType(typeId: 1)
class HiveTransaction {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String type;

  @HiveField(3)
  String reference;
  
  
  @HiveField(4)
  String status;

  @HiveField(5)
  double amount;

  @HiveField(6)
  DateTime? date;

  HiveTransaction(
      {this.id = '',
      this.name = '',
      this.type = 'CREDIT',
      this.amount = 0.0,
      this.status = '',
      this.reference = '',
      this.date});
}