import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../helper/cart_provider.dart';
import '../../../helper/show_snackbar.dart';
import '../../../models/product.dart';
import '../../../theme.dart';
import '../../product_detail/product_detail.dart';

class ProductBox extends StatelessWidget {
  final Product product;
  final bool showOutBox;
  final bool showTopRated;
  const ProductBox({
    Key? key,
    required this.product,
    required this.showOutBox,
    this.showTopRated = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProductDetail(prod: product),
            ),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Material(
              type: MaterialType.card,
              shadowColor: Colors.white,
              elevation: 5.0,
              borderRadius: BorderRadius.circular(30.0),
              child: LayoutBuilder(builder: (context, cons) {
                return Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Spacer(flex: 1),
                        Hero(
                          tag: "$showOutBox${product.id}",
                          child: Container(
                            height: cons.maxHeight * 0.5,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(product.thumbnail),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            product.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColor.textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "\$ ${product.price}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Color(0xFF6B6B6B),
                                  fontSize: 24.0,
                                ),
                              ),
                            ),
                            Material(
                              type: MaterialType.card,
                              elevation: 10.0,
                              shadowColor: Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0),
                              ),
                              color: AppColor.buttonColor,
                              child: InkWell(
                                onTap: () {
                                  context.read<CartProvider>().addItem(product);
                                  showSnackBar(
                                    context,
                                    "Succesfully Added to Cart !",
                                  );
                                },
                                child: SizedBox(
                                  height: cons.maxHeight * 0.15,
                                  width: cons.maxWidth * 0.5,
                                  child: const Center(
                                    child: Text(
                                      "Add To Cart",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (showOutBox)
                      Positioned(
                        left: -10.0,
                        top: 0.0,
                        child: Material(
                          type: MaterialType.card,
                          elevation: 10.0,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(children: [
                              const Text(
                                "Discount",
                                style: TextStyle(
                                  color: AppColor.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                ),
                              ),
                              Text(
                                "${product.discountPercentage} %",
                                style: const TextStyle(
                                  color: AppColor.buttonColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0,
                                ),
                              ),
                            ]),
                          ),
                        ),
                      ),
                    if (showTopRated)
                      Positioned(
                        right: 0.0,
                        top: 0.0,
                        child: Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: AppColor.lightColor,
                          ),
                          child: Row(children: [
                            const Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                            Text(
                              "${product.rating}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                            ),
                          ]),
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
        ),
      );
}
