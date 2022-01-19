import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:onmarket_test/Models/product_model.dart';
import '../Screens/productPage/product_page.dart';
import '../Components/styled_text.dart';
import '../Utils/constants.dart';

class ProductsSlider extends StatelessWidget {
  final String catTitle;
  final List<ProductModel> products;
  // ignore: use_key_in_widget_constructors
  const ProductsSlider({
    this.catTitle = '',
    required this.products,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StyledText(
              color: kMainTextColor,
              fontSize: 20,
              text: catTitle,
            ),
            // const StyledText(
            //   fontSize: 16,
            //   text: 'seeAll',
            // ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 200,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 0.9,
                          child: ProductPage(
                            productData: products[index],
                          ),
                        );
                      });
                },
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                          imageUrl: products[index].imageUrl,
                          fit: BoxFit.fill,
                          placeholder: (__, _) => Container(
                                width: 40,
                                alignment: Alignment.center,
                                height: 150,
                                padding: const EdgeInsets.all(0.0),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: kPrimaryColor,
                                ),
                              ),
                          imageBuilder: (context, imageProvider) => Container(
                                alignment: Alignment.center,
                                height: 150,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                          errorWidget: (context, url, error) {
                            return const Icon(Icons.error, color: Colors.grey);
                          }),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(left: 8.0),
                        width: 190,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StyledText(
                              fontSize: 18,
                              text: products[index].name,
                            ),
                            Builder(builder: (context) {
                              if (products[index].discountPrice != 0) {
                                return Row(
                                  children: [
                                    StyledText(
                                      color: kErrorColors,
                                      fontSize: 14,
                                      lineThrough: true,
                                      text: products[index]
                                          .discountPrice
                                          .toString(),
                                    ),
                                    const SizedBox(width: 2),
                                    StyledText(
                                      color: kPrimaryColor,
                                      fontSize: 16,
                                      text: products[index].price.toString() +
                                          ' EGP',
                                    ),
                                  ],
                                );
                              } else {
                                return StyledText(
                                  color: kPrimaryColor,
                                  fontSize: 18,
                                  text:
                                      products[index].price.toString() + ' EGP',
                                );
                              }
                            }),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                width: 20,
              );
            },
            itemCount: products.length,
          ),
        )
      ],
    );
  }
}
