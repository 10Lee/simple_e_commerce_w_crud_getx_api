import 'package:simple_crud_getx_airsoft_api/constants.dart';

class AirsoftModel {
  final int id;
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  int qty;

  AirsoftModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.qty = 0,
  });

  factory AirsoftModel.fromMap(dynamic map) {
    dynamic qty, imageUrl;
    map['qty'] != null ? qty = map['qty'] : qty = 0;
    map['photo'] != null
        ? imageUrl = map['photo']
        : imageUrl = '${Constants.imageUrl}/no_image.png';

    return AirsoftModel(
      id: map['id'],
      name: map['name'],
      imageUrl: imageUrl,
      description: map['description'],
      price: map['price'],
      qty: qty,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'photo': imageUrl,
        'qty': qty,
      };
}
