import 'package:flutter/material.dart';
import 'package:mini_kart_api/consts/global_colors.dart';
import 'package:mini_kart_api/models/category_model.dart';
import 'package:mini_kart_api/models/product_model.dart';
import 'package:mini_kart_api/models/users_data_model.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
      create: (context) => ProductsModel(),),
      ChangeNotifierProvider(
      create: (context) => CategoryModel(),),
      ChangeNotifierProvider(
      create: (context) => UsersDataModel(),),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MINI CART API',
        theme: ThemeData(
          scaffoldBackgroundColor: lightScaffoldColor,
          primaryColor: lightCardColor,
          backgroundColor: lightBackgroundColor,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: lightIconColor,
            ),
            backgroundColor: lightScaffoldColor,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: lightTextColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            elevation: 0,
          ),
          cardColor: lightCardColor,
          brightness: Brightness.light,
          colorScheme: ThemeData().colorScheme.copyWith(
                secondary: lightIconColor,
                brightness: Brightness.light,
              ),
        ),
        home:  HomeScreen(),
      ),
    );
  }
}
