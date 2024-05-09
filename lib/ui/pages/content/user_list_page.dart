import 'package:f_web_retool_hive/ui/controller/connectivity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../../domain/entities/user.dart';

import '../../controller/user_controller.dart';
import 'edit_user_page.dart';
import 'new_user_page.dart';

class UserListPage extends StatefulWidget {
  const UserListPage({super.key});

  @override
  State<UserListPage> createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  UserController userController = Get.find();
  ConnectivityController connectivityController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Web with Hive and GetX"),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              if (connectivityController.connection) {
                await userController.deleteUsers();
              } else {
                Get.defaultDialog(
                    title: "Warning",
                    middleText: "This action can not be done offline",
                    textConfirm: "Ok",
                    onConfirm: () {
                      Get.back();
                    });
              }
              await userController.deleteUsers();
            },
          ),
        ],
      ),
      body: Center(child: _getXlistView()),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          logInfo("Add user from UI");
          Get.to(() => const NewUserPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _getXlistView() {
    return Obx(
      () => RefreshIndicator(
        onRefresh: () async {
          await userController.getUsers();
        },
        child: ListView.builder(
          itemCount: userController.users.length,
          itemBuilder: (context, index) {
            User user = userController.users[index];
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Deleting",
                      style: TextStyle(color: Colors.white),
                    ),
                  )),
              onDismissed: (direction) {
                userController.deleteUser(user.id!);
              },
              child: Card(
                child: ListTile(
                  leading: Text(user.id.toString()),
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  onTap: () {
                    if (connectivityController.connection) {
                      Get.to(() => const EditUserPage(),
                          arguments: [user, user.id]);
                    } else {
                      Get.defaultDialog(
                          title: "Warning",
                          middleText: "This action can not be done offline",
                          textConfirm: "Ok",
                          onConfirm: () {
                            Get.back();
                          });
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
