import 'package:clan_commerce/providers/bnb_provider.dart';
import 'package:clan_commerce/providers/cart_provider.dart';
import 'package:clan_commerce/providers/category_provider.dart';
import 'package:clan_commerce/providers/search_provider.dart';
import 'package:clan_commerce/splash.dart';
import 'package:clan_commerce/themes/global_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  /// [MyApp] is the root widget of the application
  /// It's wrapped with MultiProvider
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CategoryProvider()),
      ChangeNotifierProvider(create: (context) => CartProvider()),
      ChangeNotifierProvider(create: (context) => SearchProvider()),
      ChangeNotifierProvider(create: (context) => BNBProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clan Commerce',
      theme: AppTheme.light(),
      home: const CCSplashScreen(),
    );
  }
}
