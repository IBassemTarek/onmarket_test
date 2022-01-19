class ProductModel {
  late String imageUrl;
  late String name;
  late String description;
  late num price;
  late int id;
  late num discountPrice;
  ProductModel(
    this.imageUrl,
    this.id,
    this.name,
    this.description,
    this.price,
    this.discountPrice,
  );

  ProductModel.fromJson(final Map<String, dynamic> map) {
    // ignore: unnecessary_null_comparison
    if (map == null) {
      return;
    }
    name = map['name'];
    id = map['id'];
    imageUrl = map['imageUrl'];
    description = map['description'];
    price = map['price'];
    discountPrice = map['discountPrice'];
  }
  toJson() {
    return {
      'name': name,
      'id': id,
      'imageUrl': imageUrl,
      'description': description,
      'price': price,
      'discountPrice': discountPrice,
    };
  }
}
