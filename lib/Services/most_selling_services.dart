import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onmarket_test/Models/product_model.dart';

class MostSellingServices extends GetxController {
  List<ProductModel> _ProductModels = [];
  List<ProductModel> get ProductModels => _ProductModels;
  final CollectionReference _mostSellingRef =
      FirebaseFirestore.instance.collection("MostSelling");
  getMostSelling() async {
    _mostSellingRef.get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        _ProductModels.add(ProductModel.fromJson(
          value.docs[i].data() as Map<String, dynamic>,
          // value.docs[i].data()
        ));
      }
      update();
    });
  }

  MostSellingServices() {
    getMostSelling();
  }
}
