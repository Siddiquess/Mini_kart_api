import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../services/api_handler.dart';
import '../widgets/feeds_widget.dart';

class FeedsScreen extends StatefulWidget {
  const FeedsScreen({super.key});

  @override
  State<FeedsScreen> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends State<FeedsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: FutureBuilder<List<ProductsModel>>(
        future: APIHandler.getAllProducts(),
        builder: (context, snapshot) {
          final productList = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            Center(
              child: Text("An error occured ${snapshot.error}"),
            );
          } else if (snapshot.data == null) {
            const Center(
              child: Text("Could not load data"),
            );
          }
          return GridView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: productList!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: snapshot.data![index],
                child: const FeedsWidget());
            },
          );
        },
      ),
    );
  }
}
