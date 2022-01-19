import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onmarket_test/Components/styled_button.dart';
import 'package:onmarket_test/Components/styled_text.dart';
import 'package:onmarket_test/Services/cart_services.dart';
import 'package:onmarket_test/Utils/constants.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<CartController>(
        init: Get.find<CartController>(),
        builder: (item) {
          if (item.cartItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/Empty.png'),
                  const SizedBox(
                    height: 20,
                  ),
                  const StyledText(
                    text: 'Our cart is Empty',
                    fontSize: 20,
                  )
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return Dismissible(
                        background: Container(
                          color: Colors.red,
                        ),
                        key: Key(item.cartItems[index].id.toString()),
                        onDismissed: (_) {
                          item.removeItem(item.cartItems[index].id.toString());
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          height: 140,
                          child: Row(
                            children: [
                              CachedNetworkImage(
                                  imageUrl: item.cartItems[index].imageUrl,
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
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        alignment: Alignment.center,
                                        height: 250,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade100,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                  errorWidget: (context, url, error) {
                                    return const Icon(Icons.error,
                                        color: Colors.grey);
                                  }),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StyledText(
                                      text: item.cartItems[index].name,
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    StyledText(
                                      text: (item.cartItems[index].price *
                                                  item.cartItems[index].amount)
                                              .toString() +
                                          ' EGP',
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      width: 140,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      height: 40,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              item.addToCart(
                                                amount: int.parse(
                                                    item.itemAmount(item
                                                        .cartItems[index].id)),
                                                description: item
                                                    .cartItems[index]
                                                    .description,
                                                imageUrl: item
                                                    .cartItems[index].imageUrl,
                                                name:
                                                    item.cartItems[index].name,
                                                price:
                                                    item.cartItems[index].price,
                                                id: item.cartItems[index].id,
                                              );
                                            },
                                            child: const Icon(
                                              Icons.add,
                                              color: kMainTextColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          StyledText(
                                            text: item.cartItems[index].amount
                                                .toString(),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              item.removeToCart(
                                                amount: int.parse(
                                                    item.itemAmount(item
                                                        .cartItems[index].id)),
                                                id: item.cartItems[index].id,
                                              );
                                            },
                                            child: const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 14.0),
                                              child: Icon(
                                                Icons.minimize,
                                                color: kMainTextColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: item.cartItems.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 10,
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const StyledText(
                            text: 'Total',
                            fontSize: 22,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          StyledText(
                            text: item.calcTotal().toString() + ' EGP',
                            fontSize: 16,
                            color: kPrimaryColor,
                          ),
                        ],
                      ),
                      StyledButton(
                        onTaped: () {
                          item.removeAll();
                        },
                        title: 'Checkout',
                        color: kPrimaryColor,
                        borderRadius: 10,
                        height: 40,
                        width: 100,
                        fontSize: 15,
                        textColor: Colors.white,
                      )
                    ],
                  ),
                )
              ],
            );
          }
        });
  }
}
