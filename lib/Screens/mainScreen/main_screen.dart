import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onmarket_test/Components/products_slider.dart';
import 'package:onmarket_test/Services/most_selling_services.dart';
import 'package:onmarket_test/Services/recently_viewed_services.dart';
import 'package:onmarket_test/Services/top_rated_services.dart';
import 'package:onmarket_test/Utils/constants.dart'; 
import '../../Components/styled_text.dart';
import '../../Services/auth.dart'; 

class MainScreen extends StatelessWidget {
  final _auth = AuthService();

  MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Logo.png'),
              Padding(
                padding: const EdgeInsets.only(bottom: 29),
                child: InkWell(
                  onTap:(() async {
          await _auth.signOut();
         
                  }),
                  child:  const StyledText(
              color: kErrorColors,
              fontSize: 20,
              text: 'signout',
            ),),
              ),
              GetBuilder<TopRatedServices>(
                init: Get.find<TopRatedServices>(),
                builder: (c) => ProductsSlider(
                  products: c.productModels,
                  catTitle: 'Top Rated',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GetBuilder<RecentlyViewedServices>(
                init: Get.find<RecentlyViewedServices>(),
                builder: (c) => ProductsSlider(
                  products: c.productModels,
                  catTitle: 'Recently viewed',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              GetBuilder<MostSellingServices>(
                init: Get.find<MostSellingServices>(),
                builder: (c) => ProductsSlider(
                  products: c.productModels,
                  catTitle: 'Most Selling',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
