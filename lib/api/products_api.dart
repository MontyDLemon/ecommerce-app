import 'package:ecommerce_app/db/supa_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../models/product.dart';

//! CHIAMATE API SU DUMMYJSON.COM,
//! ho pushato tutti i prodotti sul db, quindi ora non uso più queste funzioni, ma prendo i prodotti dal db !

class ProductsApi {
  static const String baseUrl = "https://dummyjson.com";

  //! Pushed all products in dummy json into my database
  //i use products on my DB
  static Future<void> pushProductsToDb() async {
    //all 100 products
    final url = Uri.parse(baseUrl + '/products?limit=100');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      //success
      final jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      final product = jsonResponse["products"] as List;
      for (int i = 0; i < product.length; i++) {
        final Product prod = Product.fromJson(product[i]);
        try {
          await SupaHandler().createProduct(prod);
        } catch (e) {
          print("error creating product number $i");
        }
      }
    } else {
      //failed
      throw ("error: ${response.statusCode}");
    }
  }

  // static Future<List> getAllProducts({int limit = 40}) async {
  //   // -> https://dummyjson.com/products?limit=50
  //   final url = Uri.parse(baseUrl + '/products?limit=$limit');
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     //success
  //     final jsonResponse =
  //         convert.jsonDecode(response.body) as Map<String, dynamic>;
  //     return jsonResponse["products"];
  //   } else {
  //     //failed
  //     print("errore: ${response.statusCode}");
  //     throw ("error: ${response.statusCode}");
  //   }
  // }
//
////di base ritorna tutti i prodotti con uno sconto maggiore del 15%
  // static Future<List> getDiscountProducts(
  //     {double minimumDiscount = 15.0}) async {
  //   // -> https://dummyjson.com/products?limit=50
  //   final url = Uri.parse(baseUrl + '/products?limit=100');
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     //success
  //     final jsonResponse =
  //         convert.jsonDecode(response.body) as Map<String, dynamic>;
  //     final List discountProducts = jsonResponse["products"];
  //     return discountProducts
  //         .where((element) => element["discountPercentage"] > minimumDiscount)
  //         .toList();
  //   } else {
  //     //failed
  //     print("errore: ${response.statusCode}");
  //     throw ("error: ${response.statusCode}");
  //   }
  // }
//
////torna i prodotti più popolari (quelli che hanno un rating > di un tot (di base 4.7))
  // static Future<List> getPopularProducts({double minPopolarity = 4.7}) async {
  //   // -> https://dummyjson.com/products?limit=50
  //   final url = Uri.parse(baseUrl + '/products?limit=100');
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     //success
  //     final jsonResponse =
  //         convert.jsonDecode(response.body) as Map<String, dynamic>;
  //     final List discountProducts = jsonResponse["products"];
  //     return discountProducts
  //         .where((element) => element["rating"] > minPopolarity)
  //         .toList();
  //   } else {
  //     //failed
  //     print("errore: ${response.statusCode}");
  //     throw ("error: ${response.statusCode}");
  //   }
  // }
//
  // //torna i prodotti più popolari (quelli che hanno un rating > di un tot (dii base 4.7))
  // static Future<List> getProdutsByCategory(String category) async {
  //   // -> https://dummyjson.com/products?limit=50
  //   final url = Uri.parse(baseUrl + '/products?limit=100');
  //   final response = await http.get(url);
  //   if (response.statusCode == 200) {
  //     //success
  //     final jsonResponse =
  //         convert.jsonDecode(response.body) as Map<String, dynamic>;
  //     final List categoryProducts = jsonResponse["products"];
  //     return categoryProducts
  //         .where((element) => element["category"] == category)
  //         .toList();
  //   } else {
  //     //failed
  //     print("errore: ${response.statusCode}");
  //     throw ("error: ${response.statusCode}");
  //   }
  // }

}
