import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  late String imageUrl;
  late String name;
  late String description;
  late num price;
  late int id;
  late int amount;

  late num discountPrice;
  CartModel(
    this.amount,
    this.imageUrl,
    this.id,
    this.name,
    this.description,
    this.price,
    this.discountPrice,
  );

  CartModel.fromDocumentSnapShot(DocumentSnapshot map) {
    // ignore: unnecessary_null_comparison
    if (map == null) {
      return;
    }
    name = map['name'];
    amount = map['amount'];
    id = map['id'];
    imageUrl = map['imageUrl'];
    description = map['description'];
    price = map['price'];
  }
  // toJson() {
  //   return {
  //     'name': name,
  //     'id': id,
  //     'amount': amount,
  //     'imageUrl': imageUrl,
  //     'description': description,
  //     'price': price,
  //     'discountPrice': discountPrice,
  //   };
  // }
}
