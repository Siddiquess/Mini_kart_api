import 'package:flutter/material.dart';
import 'package:mini_kart_api/models/product_model.dart';
import 'package:provider/provider.dart';

import 'feeds_widget.dart';

class FeedsGridWidget extends StatelessWidget {
  const FeedsGridWidget({
    Key? key,
    required this.productList,
  }) : super(key: key);
  final List<ProductsModel> productList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0.0,
          mainAxisSpacing: 0.0,
          childAspectRatio: 0.6),
      itemBuilder: (ctx, index) {
        return ChangeNotifierProvider.value(
          value: productList[index],
          child: const FeedsWidget(),
        );
      },
    );
  }
}
