import 'package:ecommerce_app/helper/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/authentication_helper.dart';
import '../helper/show_snackbar.dart';
import 'authentication_page/authentication_page.dart';
import 'cart_page.dart';
import 'home_page/home_page.dart';
import 'notify_page.dart';
import 'search_page.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({Key? key}) : super(key: key);

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      bottomNavigationBar: _buildNavBar(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) => AppBar(
        title: const Text("Monty Store"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              //go to cart page
              final String result = await AuthenticationHelper().logOut();
              if (result == "success") {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AuthenticationPage(),
                    ),
                    (route) => false);
              } else {
                showSnackBar(context, "Error Loging Out !");
              }
            },
          ),
        ],
      );
  Widget _buildBody(BuildContext context) {
    switch (currentIndex) {
      case 1:
        return const SearchPage();
      case 2:
        return const NotifyPage();
      case 3:
        return const CartPage();
      default:
        return const HomePage();
    }
  }

  BottomNavigationBar _buildNavBar(BuildContext context) => BottomNavigationBar(
          onTap: (newIndex) => setState(() => currentIndex = newIndex),
          currentIndex: currentIndex,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "Home"),
            const BottomNavigationBarItem(
                icon: Icon(Icons.search), label: "Search"),
            const BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none),
              label: "notify",
            ),
            BottomNavigationBarItem(
                icon: context.read<CartProvider>().prods.isEmpty
                    ? const Icon(Icons.shopping_bag)
                    : Stack(
                        clipBehavior: Clip.none,
                        children: [
                          const Icon(Icons.shopping_bag),
                          Positioned(
                            top: -10.0,
                            right: -10.0,
                            child: Container(
                              width: 20.0,
                              height: 20.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1.0,
                                  color: Colors.red,
                                ),
                              ),
                              child: FittedBox(
                                child: Text(
                                  "${context.read<CartProvider>().itemsLength}",
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                label: "Cart"),
          ]);
}
