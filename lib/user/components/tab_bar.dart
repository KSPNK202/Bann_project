import 'package:baan_app/user/models/food.dart';
import 'package:flutter/material.dart';

class MyTabbar extends StatelessWidget {
  final TabController tabController;

  const MyTabbar({
    super.key,
    required this.tabController,
  });

  List<Tab> _buildCategorTabs() {
  return FoodCategory.values.map((category) {
    return Tab(
      text: category.toString().split('.').last,
    );
  }).toList();
}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        controller: tabController,
        tabs: _buildCategorTabs(),
      ),
    );
  }
}