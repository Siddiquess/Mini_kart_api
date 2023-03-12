import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_kart_api/models/category_model.dart';
import 'package:mini_kart_api/models/product_model.dart';
import 'package:mini_kart_api/models/users_data_model.dart';
import '../consts/api_constants.dart';

class APIHandler {
  static Future<List<dynamic>> getData(String target) async {
    final uri = Uri.https(BASE_URI, "api/v1/$target");
    final response = await http.get(uri);
    final data = jsonDecode(response.body);
    List<dynamic> dataList = [];

    for (var element in data) {
      dataList.add(element);
    }
    return dataList;
  }

  static Future<List<ProductsModel>> getAllProducts() async {
    final productList = await getData("products");
    return ProductsModel.productsFromSnapshot(productList);
  }

  static Future<List<CategoryModel>> getAllCategory() async {
    final categoryList = await getData("categories");
    return CategoryModel.categoriesFromSnapshot(categoryList);
  }

  static Future<List<UsersDataModel>> getAllUserData() async {
    final userDataList = await getData("users");
    return UsersDataModel.usersFromSnapshot(userDataList);
  }
}
