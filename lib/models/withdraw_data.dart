class WithdrawData {
  String? amount;
  String? description;
  String? acctHolder;
  String? acctNumber;
  String? bankName;

  WithdrawData(
      {this.amount,
      this.description,
      this.acctHolder,
      this.acctNumber,
      this.bankName});

  factory WithdrawData.fromJson(Map<String, dynamic> json) => WithdrawData(
        amount: json["amount"],
        description: json["description"],
        acctHolder: json["acctHolder"],
        acctNumber: json["acctNumber"],
        bankName: json["bankName"],
      );
}
