import 'package:ecommerce_app/db/key.dart';
import 'package:ecommerce_app/models/user.dart' as app_user;
import 'package:supabase/supabase.dart';

import '../models/product.dart';

//stesse operazioni ma stavolta prendo i dati dal db anzichè in dummyJson
class SupaHandler {
  final client = SupabaseClient(supabaseUrl, supabaseKey);

//take all products
  Future<List<Product>> readAllProducts() async {
    final response = await client.from("product").select('*').execute();
    if (response.hasError) {
      throw (response.error!);
    }
    final data = response.data as List;
    List<Product> allProducts = List.generate(
      data.length,
      (i) => Product.fromJson(data[i]),
    );

    //for (int i = 0; i < data.length; i++) {
    //  final Product prod = Product.fromJson(data[i]);
    //  allProducts.add(prod);
    //}

    return allProducts;
  }

//* create
  Future<void> createProduct(Product prod) async {
    final response =
        await client.from("product").insert(prod.toJson()).execute();
    if (response.hasError) {
      throw ("error creating product !");
    }
  }

//* Read
  Future<Product> readProduct(int id) async {
    final response =
        await client.from("product").select().eq('id', id).single().execute();

    if (response.hasError) {
      throw ("product Not Found!");
    }
    final Product product = Product.fromJson(response.data);

    return product;
  }

  Future<List<Product>> getPopularProducts({double minPopolarity = 4.7}) async {
    final response = await client
        .from("product")
        .select()
        .gte('rating', minPopolarity)
        .execute();
    if (response.hasError) {
      throw ("error getting popular products");
    }

    final data = response.data as List;
    List<Product> popularProducts = List.generate(
      data.length,
      (index) => Product.fromJson(
        data[index],
      ),
      growable: false,
    );
    return popularProducts;
  }

  Future<List<Product>> getDiscountProducts({double minDiscount = 12.3}) async {
    final response = await client
        .from("product")
        .select()
        .gte('discountPercentage', minDiscount)
        .execute();
    if (response.hasError) {
      throw ("error getting discounts products");
    }

    final data = response.data as List;
    List<Product> discountProducts = List.generate(
      data.length,
      (index) => Product.fromJson(
        data[index],
      ),
      growable: false,
    );
    return discountProducts;
  }

  Future<List<Product>> getProductsByCategory(String category) async {
    final response = await client
        .from("product")
        .select()
        .filter('category', 'eq', category)
        .execute();

    if (response.hasError) {
      throw ("error getting discounts products");
    }

    final data = response.data as List;
    List<Product> categoryProducts = List.generate(
      data.length,
      (i) => Product.fromJson(data[i]),
      growable: false,
    );
    return categoryProducts;
  }

  //! METODI UTENTE

  Future<void> createUser(app_user.User user) async {
    final response = await client.from("user").insert(user.toJson()).execute();
  }
}
