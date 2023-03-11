import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mini_kart_api/widgets/category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Category")),
      body: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          childAspectRatio: 1.2,
        ),
        itemBuilder: (context, index) {
          return CategoryWidget();
        },
      ),
    );
  }
}
