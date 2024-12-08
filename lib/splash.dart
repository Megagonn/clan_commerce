import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:clan_commerce/views/home.dart';
import 'package:flutter/material.dart';

class CCSplashScreen extends StatelessWidget {
  const CCSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterSplashScreen.scale(
        backgroundColor: Colors.white,
        childWidget: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/images/2.png"),
              fit: BoxFit.fill,
            ),
          ),
        ),
        nextScreen: const CCHome(),
      ),
    );
  }
}