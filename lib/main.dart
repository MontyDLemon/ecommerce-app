import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helper/cart_provider.dart';
import 'helper/user_provider.dart';
import 'router.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //check if user is logged in
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'E-Coomerce App',
        theme: AppTheme.appTheme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
