import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:mini_kart_api/models/category_model.dart';
import 'package:mini_kart_api/models/product_model.dart';
import 'package:mini_kart_api/models/users_data_model.dart';
import '../consts/api_constants.dart';

class APIHandler {
  static Future<List<dynamic>> getData({required String target, String? limit}) async {
    try {
      final uri = Uri.https(BASE_URI, "api/v1/$target",
          target == "products" ? {"offset": "0", "limit": limit} : {});
      final response = await http.get(uri);
      final data = jsonDecode(response.body);
      List<dynamic> dataList = [];

      if (response.statusCode != 200) {
        throw data["message"];
      }

      for (var element in data) {
        dataList.add(element);
      }
      return dataList;
    } catch (error) {
      log('An error occured');
      throw error.toString();
    }
  }

  static Future<List<ProductsModel>> getAllProducts({required String limit}) async {
    final productList = await getData(target: "products",limit: limit);
    return ProductsModel.productsFromSnapshot(productList);
  }

  static Future<List<CategoryModel>> getAllCategory() async {
    final categoryList = await getData(target: "categories");
    return CategoryModel.categoriesFromSnapshot(categoryList);
  }

  static Future<List<UsersDataModel>> getAllUserData() async {
    final userDataList = await getData(target: "users");
    return UsersDataModel.usersFromSnapshot(userDataList);
  }

  static Future<ProductsModel> getProductbyID(String id) async {
    try {
      final uri = Uri.https(BASE_URI, "api/v1/products/$id");

      final response = await http.get(uri);

      final data = jsonDecode(response.body);

      if (response.statusCode != 200) {
        log(data["name"]);
        throw data["message"];
      }

      return ProductsModel.fromJson(data);
    } catch (error) {
      log('An error occured $error');
      throw error.toString();
    }
  }
}
