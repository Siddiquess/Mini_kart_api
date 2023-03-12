import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:mini_kart_api/consts/global_colors.dart';
import 'package:mini_kart_api/models/product_model.dart';
import 'package:mini_kart_api/screens/category_screen.dart';
import 'package:mini_kart_api/screens/users_screes.dart';
import 'package:mini_kart_api/services/api_handler.dart';
import 'package:mini_kart_api/widgets/appbar_icons.dart';
import 'package:mini_kart_api/widgets/feeds_grid.dart';
import 'package:mini_kart_api/widgets/sale_widget.dart';
import 'package:page_transition/page_transition.dart';
import 'feeds_screen.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final List images = [
    "assets/pngwing.com.png",
    "assets/shoe_2.png",
    "assets/shoe_3.png",
  ];

  final List offer = [
    "50",
    "60",
    "20",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final TextEditingController textEditingController = TextEditingController();
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          leading: AppBarIcons(
            icon: IconlyBold.category,
            function: () {
              Navigator.push(
                context,
                PageTransition(
                  child: const CategoryScreen(),
                  type: PageTransitionType.fade,
                ),
              );
            },
          ),
          actions: [
            AppBarIcons(
              icon: IconlyBold.user3,
              function: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: const UsersScreen(),
                    type: PageTransitionType.fade,
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 18,
              ),
              TextField(
                controller: textEditingController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: "Search",
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 1,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  suffixIcon: Icon(
                    IconlyLight.search,
                    color: lightIconColor,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 18,
                      ),
                      SizedBox(
                        height: size.height * 0.2,
                        child: Swiper(
                          autoplay: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return SaleWidget(
                              images: images[index],
                              offer: offer[index],
                            );
                          },
                          pagination: const SwiperPagination(
                            alignment: Alignment.bottomCenter,
                            builder: DotSwiperPaginationBuilder(
                              color: Colors.white,
                              activeColor: Colors.orangeAccent,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Text(
                              "Latest Products",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            const Spacer(),
                            AppBarIcons(
                                function: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: FeedsScreen(),
                                    ),
                                  );
                                },
                                icon: IconlyBold.arrowRight2),
                          ],
                        ),
                      ),
                      FutureBuilder<List<ProductsModel>>(
                        future: APIHandler.getAllProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                          return FeedsGridWidget(productList: snapshot.data!);
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
