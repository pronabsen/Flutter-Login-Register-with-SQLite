import 'package:flutter/material.dart';
import 'package:library_management/database/database_helper.dart';
import 'package:library_management/models/user.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
      future: DatabaseHelper.instance.getAllUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              UserModel item = snapshot.data![index];
              return ListTile(
                title: Text(item.name),
                leading: Text(item.id.toString()),
                trailing: Text(item.email.toString()),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

}
