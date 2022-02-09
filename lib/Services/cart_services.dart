import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onmarket_test/Models/cart_model.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  Rx<List<CartModel>> cartList = Rx<List<CartModel>>([]);
  final CollectionReference _cartRef =
      FirebaseFirestore.instance.collection("Cart");
  List<CartModel> get cartItems => cartList.value;
  String itemAmount(int productID) {
    // ignore: unnecessary_null_comparison
    if (cartItems != null || cartItems.isEmpty) {
      final contains = cartItems.any((u) => u.id == productID);
      if (contains) {
        return cartItems
            .singleWhere((element) => element.id == productID)
            .amount
            .toString();
      } else {
        return '0';
      }
    } else {
      return '0';
    }
  }

  @override
  // ignore: must_call_super
  void onInit() {
    cartList.bindStream(cartStream());
  }

  Stream<List<CartModel>> cartStream() {
    return _cartRef.snapshots().map((QuerySnapshot querySnapshot) {
      List<CartModel> val = [];
      for (var element in querySnapshot.docs) {
        val.add(CartModel.fromDocumentSnapShot(element));
      }
      return val;
    });
  }

  Future<void> addToCart({
    required String imageUrl,
    required String name,
    required String description,
    required num price,
    required int id,
    required int amount,
  }) async {
    try {
      var docRef = _cartRef.doc("$id");
      docRef.get().then((doc) => {
            if (doc.exists)
              {
                {
                  _cartRef.doc("$id").update({
                    "amount": amount + 1,
                  })
                }
              }
            else
              {
                _cartRef.doc("$id").set({
                  "imageUrl": imageUrl,
                  "name": name,
                  "description": description,
                  "price": price,
                  "id": id,
                  "amount": amount + 1,
                })
              }
          });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> removeToCart({
    required int id,
    required int amount,
  }) async {
    try {
      var docRef = _cartRef.doc("$id");
      docRef.get().then((doc) => {
            if (doc.exists)
              {
                if (amount != 1 && amount != 0)
                  {
                    _cartRef.doc("$id").update({
                      "amount": amount - 1,
                    })
                  }
                else if (amount == 1)
                  {_cartRef.doc("$id").delete()}
              }
          });
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }

  Future<void> removeAll() async {
    _cartRef.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  }

  Future<void> removeItem(String id) async {
    _cartRef.doc(id).delete();
  }

  num calcTotal() {
    num totalPrice = 0;
    for (var element in cartItems) {
      totalPrice += element.amount * element.price;
    }
    return totalPrice;
  }
}
