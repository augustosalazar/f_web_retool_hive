import 'package:f_web_retool_hive/ui/controller/connectivity_controller.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../domain/entities/user.dart';
import '../../domain/use_case/user_usecase.dart';

class UserController extends GetxController {
  final RxList<User> _users = <User>[].obs;
  final UserUseCase userUseCase = Get.find();
  final ConnectivityController connectivity = Get.find();

  List<User> get users => _users;

  @override
  void onInit() {
    getUsers();
    super.onInit();
  }

  Future<void> getUsers() async {
    logInfo("Getting users");
    _users.value = await userUseCase.getUsers();
  }

  Future<void> addUser(User user) async {
    logInfo("Add user");
    await userUseCase.addUser(user);
    getUsers();
  }

  Future<void> updateUser(User user) async {
    logInfo("Update user");
    await userUseCase.updateUser(user);
    getUsers();
  }

  Future<void> deleteUser(int id) async {
    logInfo("deleteUser user $id");
    await userUseCase.deleteUser(id);
    getUsers();
  }

  Future<void> deleteUsers() async {
    logInfo("deleteUsers");
    await userUseCase.deleteUsers();
    getUsers();
  }
}
