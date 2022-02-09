import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onmarket_test/Components/styled_text.dart';
import 'package:onmarket_test/Controllers/bottom_bar_controller.dart';
import 'package:onmarket_test/Models/product_model.dart';
import 'package:onmarket_test/Services/cart_services.dart';
import 'package:onmarket_test/Utils/constants.dart';

class ProductPage extends StatelessWidget {
  final ProductModel productData;
  // ignore: use_key_in_widget_constructors
  const ProductPage({required this.productData});
  @override
  Widget build(BuildContext context) {
    final _width = Get.mediaQuery.size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CachedNetworkImage(
            imageUrl: productData.imageUrl,
            fit: BoxFit.fill,
            placeholder: (__, _) => Container(
                  width: 40,
                  alignment: Alignment.center,
                  height: 150,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: kPrimaryColor,
                  ),
                ),
            imageBuilder: (context, imageProvider) => Container(
                  alignment: Alignment.center,
                  height: 250,
                  width: _width,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            errorWidget: (context, url, error) {
              return const Icon(Icons.error, color: Colors.grey);
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StyledText(
                    fontSize: 20,
                    text: productData.name,
                  ),
                  Builder(builder: (context) {
                    if (productData.discountPrice != 0) {
                      return Row(
                        children: [
                          StyledText(
                            color: kErrorColors,
                            fontSize: 14,
                            lineThrough: true,
                            text: productData.discountPrice.toString(),
                          ),
                          const SizedBox(width: 2),
                          StyledText(
                            color: kPrimaryColor,
                            fontSize: 16,
                            text: productData.price.toString() + ' EGP',
                          ),
                        ],
                      );
                    } else {
                      return StyledText(
                        color: kPrimaryColor,
                        fontSize: 18,
                        text: productData.price.toString() + ' EGP',
                      );
                    }
                  }),
                ],
              ),
              const SizedBox(height: 8),
              StyledText(
                fontSize: 15,
                text: productData.description,
              ),
            ],
          ),
        ),
        const Spacer(),
        SizedBox(
          child: Column(
            children: [
              SizedBox(
                height: 30,
                child: GetX<CartController>(
                  init: Get.put<CartController>(CartController()),
                  builder: (item) => Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            item.removeToCart(
                              amount:
                                  int.parse(item.itemAmount(productData.id)),
                              id: productData.id,
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            color: kErrorColors,
                            child: const Icon(Icons.remove),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.grey.shade300,
                          alignment: Alignment.center,
                          child: Text(item.itemAmount(productData.id)),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            item.addToCart(
                              amount:
                                  int.parse(item.itemAmount(productData.id)),
                              description: productData.description,
                              imageUrl: productData.imageUrl,
                              name: productData.name,
                              price: productData.price,
                              id: productData.id,
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            child: const Icon(Icons.add),
                            color: kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GetBuilder<BottomNavigationBarModel>(
                builder: (c) => InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    c.chnageSelectedValue(1);
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    color: kPrimaryColor,
                    child: const StyledText(
                      fontSize: 20,
                      text: 'Go to cart',
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
