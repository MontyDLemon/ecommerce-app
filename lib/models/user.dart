import 'package:ecommerce_app/models/product.dart';
import 'package:supabase/supabase.dart' as client;

class User {
  final String id;
  final String name;
  final String surname;
  final String email;
  String? profileImage;
  List<Product>? favoriteProducts;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.email,
    this.favoriteProducts,
    this.profileImage,
  });

  static User fromSupabaseUser(client.User newUser) {
    final User currentUser = User(
      id: newUser.id,
      name: newUser.userMetadata['name'],
      surname: newUser.userMetadata["surname"],
      email: newUser.email!,
    );
    return currentUser;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "email": email,
      };
}
