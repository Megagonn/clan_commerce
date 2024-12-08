

import 'package:clan_commerce/providers/cart_provider.dart';
import 'package:clan_commerce/providers/category_provider.dart';
import 'package:clan_commerce/providers/search_provider.dart';
import 'package:clan_commerce/splash.dart';
import 'package:clan_commerce/themes/global_themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers:[
      ChangeNotifierProvider(create: (context)=> CategoryProvider()),
      ChangeNotifierProvider(create: (context)=> CartProvider()),
      ChangeNotifierProvider(create: (context)=> SearchProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.light(),
      home: const CCSplashScreen(),
    );
  }
}

