import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/entities/user.dart';
import '../../controller/user_controller.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({super.key});

  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('New User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: controllerFirstName,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                )),
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: controllerLastName,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                )),
            const SizedBox(
              height: 20,
            ),
            TextField(
                controller: controllerEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                )),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                      flex: 2,
                      child: ElevatedButton(
                          onPressed: () async {
                            await userController.addUser(User(
                                email: controllerEmail.text,
                                firstName: controllerFirstName.text,
                                lastName: controllerLastName.text));
                            Get.back();
                          },
                          child: const Text("Save")))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
