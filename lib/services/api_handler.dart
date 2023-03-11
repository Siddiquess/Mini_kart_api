import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_kart_api/models/product_model.dart';
import '../consts/api_constants.dart';

class APIHandler {
  static Future<List<ProductsModel>> getAllProducts() async {
    final uri = Uri.https(BASE_URI, "api/v1/products");
    final response = await http.get(uri);
    final data = jsonDecode(response.body);
    List<dynamic> productList = [];

    for (var element in data) {
      productList.add(element);
    }
    return ProductsModel.productsFromSnapshot(productList);
  }
}
