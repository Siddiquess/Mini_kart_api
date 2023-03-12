import 'package:flutter/material.dart';
import 'package:mini_kart_api/models/category_model.dart';
import 'package:mini_kart_api/services/api_handler.dart';
import 'package:mini_kart_api/widgets/category.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final categoryList = Provider.of<CategoryModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text("Category")),
      body: FutureBuilder<List<CategoryModel>>(
        future: APIHandler.getAllCategory(),
        builder: (context, snapshot) {
          final categoryList = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null) {
            return const Center(
              child: Text("Could not load data"),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text("Error occured"),
            );
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categoryList!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 1.2,
            ),
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: snapshot.data![index],
                child: const CategoryWidget(),
              );
            },
          );
        },
      ),
    );
  }
}
