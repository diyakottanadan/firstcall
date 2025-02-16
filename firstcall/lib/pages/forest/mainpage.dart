import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'widgets/bottom_navigation.dart';
import 'widgets/drawer_nav.dart';

final pages = [
  ForestDashboard(),
  ForestDashboard(),
  ForestDashboard(),
  ForestDashboard()
];
final tites = ["Home", "Home", "Home", "Home"];

class ForestMainPage extends StatelessWidget {
  const ForestMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChanged,
      builder: (context, int index, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(tites[index]),
            actions: [],
          ),
          bottomNavigationBar: const CustomerBottomNav(),
          body: pages[index],
          drawer: const CustomerDrawer(),
        );
      },
    );
  }
}
