import 'package:ecommerce_app/db/key.dart';
import 'package:ecommerce_app/db/supa_handler.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/models/user.dart' as app_user;
import 'package:supabase/supabase.dart';

class AuthenticationHelper {
  final supaHandler = SupaHandler();
  late final SupabaseClient _client;
  AuthenticationHelper() {
    _client = supaHandler.client;
  }

//* LOGIN
  Future<app_user.User> login(
    String? email,
    String? password,
    bool rememberCredential,
  ) async {
    try {
      if (!canLogin(email, password)) {
        throw ("Invalid Credential !");
      }
      final response = await _client.auth.signIn(
        email: email,
        password: password,
      );
      //failed
      if (response.error != null) {
        throw ("Error login: ${response.error?.message}");
      }
      //success
      //* save userCredential or TOKEN on sharedPreferences
      final app_user.User newUser =
          app_user.User.fromSupabaseUser(response.user!);
      _client.from("user").insert(newUser.toJson());
      return newUser;
    } catch (e) {
      rethrow;
    }
  }

//* REGISTER
  Future<app_user.User> register(
    String email,
    String password,
    String name,
    String surname,
  ) async {
    try {
      if (!canRegister(email, password, name, surname)) {
        throw ("Invalid Credential");
      }
      final response = await _client.auth.signUp(email, password,
          options: AuthOptions(
            redirectTo: redirectUrl,
          ),
          userMetadata: {
            'name': name,
            'surname': surname,
          });
      //failed
      if (response.error != null) {
        throw ("${response.error}");
      }
      //success
      final app_user.User newUser =
          app_user.User.fromSupabaseUser(response.user!);
      return newUser;
    } catch (e) {
      rethrow;
    }
  }

//* LOGOUT
  Future<String> logOut() async {
    try {
      final response = await _client.auth.signOut();

      final error = response.error;
      if (error == null) {
        //success
        return "success";
      } else {
        return error.message;
      }
    } catch (e) {
      print("error logOut: $e");
      rethrow;
    }
  }

//easy data control for now ! don't need to implement all login flow
  bool canLogin(String? email, String? password) =>
      email != null &&
      password != null &&
      email.length > 8 &&
      email.length < 40 &&
      password.length > 8 &&
      password.length < 20;

  bool canRegister(
    String? email,
    String? password,
    String? name,
    String? surname,
  ) =>
      canLogin(email, password) && name != null && surname != null;

  void createProduct(Product prod) {
    supaHandler.createProduct(prod); //createProduct(prod);
  }
}
