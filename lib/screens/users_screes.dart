import 'package:flutter/material.dart';
import 'package:mini_kart_api/models/users_data_model.dart';
import 'package:mini_kart_api/services/api_handler.dart';
import 'package:provider/provider.dart';

import '../widgets/users_widget.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("User Data")),
        body: FutureBuilder<List<UsersDataModel>>(
          future: APIHandler.getAllUserData(),
          builder: (context, snapshot) {
            final userData = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("An error occured ${snapshot.error}"),
              );
            } else if (snapshot.data == null) {
              return const Center(
                child: Text("Could not loaad data"),
              );
            }
            return ListView.builder(
              itemCount: userData!.length,
              itemBuilder: (ctx, index) {
                return ChangeNotifierProvider.value(
                  value: userData[index],
                  child: const UsersWidget());
              },
            );
          },
        ));
  }
}
