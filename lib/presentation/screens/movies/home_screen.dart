import 'package:flutter/material.dart';
import 'package:trending_movies/config/constants/environment.dart';

class HomeScreen extends StatelessWidget {
  // name of page for goRouter
  static const name = "home-screen";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Environment.apiKeyTMDB),
      ),
    );
  }
}
