class Transaction {
  String id, name, type, reference, status;
  double amount;
  DateTime? date;

  Transaction(
      {this.id = '',
      this.name = '',
      this.type = 'CREDIT',
      this.amount = 0.0,
      this.status = '',
      this.reference = '',
      this.date});

  factory Transaction.fromTransaction(Map<String, dynamic> json) => Transaction(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      amount: json['amount'].toDouble(),
      reference: json['reference'],
      date: DateTime.parse(json['date']));

  toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'amount': amount,
        'reference': reference,
        'status': status,
        'date': date!.toIso8601String(),
      };
}
