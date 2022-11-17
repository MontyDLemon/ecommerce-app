import 'package:ecommerce_app/theme.dart';
import 'package:flutter/material.dart';

import '../../../models/product.dart';
import '../../all_product_page.dart';
import 'product_box.dart';

class CustomFutureBuilder extends StatelessWidget {
  final Future<List<Product>> dbRequest;
  final String text;
  const CustomFutureBuilder({
    Key? key,
    required this.dbRequest,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: dbRequest,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.done) {
            if (snap.hasError) {
              return Center(
                child: Text("${snap.error}"),
              );
            }
            //snap ha i dati
            final products = snap.data! as List<Product>;
            return Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$text Products",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: AppColor.textColor,
                      ),
                    ),
                    TextButton(
                      child: const Text("View All"),
                      onPressed: () {
                        //apri pagina vedi tutti i prodotti popolari
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => AllProductPage(
                              products: products,
                              title: text,
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: products.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return ProductBox(
                        product: products[index],
                        //Nei prodotti in sconto mostro il box in alto a destra
                        showOutBox: text == "Discount",
                      );
                    }),
              ),
            ]);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
}
