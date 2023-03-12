import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:mini_kart_api/consts/global_colors.dart';
import 'package:mini_kart_api/models/users_data_model.dart';
import 'package:provider/provider.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userDataList = Provider.of<UsersDataModel>(context);
    Size size = MediaQuery.of(context).size;
    return ListTile(
      leading: FancyShimmerImage(
        height: size.width * 0.15,
        width: size.width * 0.15,
        errorWidget: const Icon(
          IconlyBold.danger,
          color: Colors.red,
          size: 28,
        ),
        imageUrl: userDataList.avatar.toString(),
        boxFit: BoxFit.fill,
      ),
      title:  Text(userDataList.name.toString()),
      subtitle:  Text(userDataList.email.toString()),
      trailing: Text(
        userDataList.role.toString(),
        style: TextStyle(
          color: lightIconColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
