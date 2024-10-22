import 'package:flutter/material.dart';

import 'package:trending_movies/presentation/views/views.dart';
import 'package:trending_movies/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  // name of page for goRouter`
  static const name = "home-screen";
  final int pageIndex;
  HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = <Widget>[
    const HomeView(),
    const SizedBox(), //populars
    const FavoriteView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: pageIndex,
      ),
    );
  }
}
