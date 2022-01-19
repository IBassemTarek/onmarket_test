import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onmarket_test/Models/product_model.dart';

class RecentlyViewedServices extends GetxController {
  List<ProductModel> _productModels = [];
  List<ProductModel> get productModels => _productModels;
  final CollectionReference _recentlyViewedRef =
      FirebaseFirestore.instance.collection("RecentlyViewed");
  getRecentlyViewed() async {
    _recentlyViewedRef.get().then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        _productModels.add(ProductModel.fromJson(
          value.docs[i].data() as Map<String, dynamic>,
          // value.docs[i].data()
        ));
      }
      update();
    });
  }

  RecentlyViewedServices() {
    getRecentlyViewed();
  }
}
