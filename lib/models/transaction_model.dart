class TransactionModel {
  final int id;
  final String transCode;
  final String date;

  TransactionModel({
    required this.id,
    required this.transCode,
    required this.date,
  });

  factory TransactionModel.fromMap(dynamic map) {
    return TransactionModel(
      id: map['id'],
      transCode: map['trans_code'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'trans_code': transCode,
        'date': date,
      };
}
