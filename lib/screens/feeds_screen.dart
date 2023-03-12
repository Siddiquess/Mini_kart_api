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
  int limit = 10;

  bool _isLoading = false;

  bool _isLimit = false;

  final ScrollController _scrollController = ScrollController();

  Future<List<ProductsModel>> scrollingFun() async {
    _scrollController.addListener(() async {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _isLoading = true;
        limit += 10;
        getProducts();
        _isLoading = false;
      }
    });

    return APIHandler.getAllProducts(limit: limit.toString());
  }

  getProducts() async {
    await APIHandler.getAllProducts(limit: limit.toString());
    setState(() {});
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Products'),
      ),
      body: FutureBuilder<List<ProductsModel>>(
        future: scrollingFun(),
        builder: (context, snapshot) {
          // final productList = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting && _isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
          return  const Center(
              child: Text("An error occured"),
            );
          } else if (snapshot.data == null) {
          return  const Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
            controller: _scrollController,
            // shrinkWrap: true,
            // physics: const ScrollPhysics(),
            itemCount: snapshot.data!.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 0.65,
            ),
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                  value: snapshot.data![index], child: const FeedsWidget());
            },
          );
        },
      ),
    );
  }
}
