class DetailTransactionModel {
  final int id;
  final String name;
  final String description;
  final int price;
  final String photo;
  final int qty;

  DetailTransactionModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.qty,
    required this.photo,
  });

  factory DetailTransactionModel.fromMap(dynamic map) {
    return DetailTransactionModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      price: map['price'],
      qty: map['qty'],
      photo: map['photo'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'qty': qty,
        'photo': photo,
      };
}
