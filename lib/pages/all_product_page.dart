import 'package:ecommerce_app/pages/home_page/components/product_box.dart';
import 'package:flutter/material.dart';
import '../db/supa_handler.dart';
import '../models/product.dart';

class AllProductPage extends StatelessWidget {
  //se non lo passo ritorno un futurebuilder con la chiamata alle api
  final List<Product>? products;
  //se products è null, allora devo specificare category //!(devo dargli un valore di default)
  final String category;
  final String? title;
  const AllProductPage({
    Key? key,
    this.products,
    this.title,
    this.category = "smartphones",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      //tutti i prodotti popolari - tutti i prodotti in sconto
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) => AppBar(
        title: Text(title != null ? title! + " Products" : category),
      );

  Widget _buildBody(BuildContext context) => SafeArea(
        child: products == null
            ? _buildProducts(context)
            : _buildGridView(products!),
      );

//faccio chiamata alle api in base alla stringa passata
  _buildProducts(BuildContext context) => FutureBuilder(
        future: SupaHandler().getProductsByCategory(category),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snap.hasError) {
              return Center(
                child: Text("${snap.error}"),
              );
            } else {
              //snap ha i dati
              final prods = snap.data! as List<Product>;
              return _buildGridView(prods);
            }
          }
        },
      );

  Widget _buildGridView(List<Product> prods) => GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 15.0,
        mainAxisSpacing: 40.0,
      ),
      itemCount: prods.length,
      itemBuilder: (context, index) {
        final Product prod = prods[index];
        return ProductBox(
          product: prod,
          showOutBox: title == "Discount",
          showTopRated: title == "Top Rated",
        );
      });
}
