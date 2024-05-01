import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:f_web_retool_hive/data/datasources/local/i_local_data_source.dart';
import 'package:f_web_retool_hive/data/models/user_db.dart';
import 'package:f_web_retool_hive/ui/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'data/core/network_info.dart';
import 'data/datasources/local/local_data_source.dart';
import 'data/datasources/remote/i_user_datasource.dart';
import 'data/datasources/remote/user_datasource.dart';
import 'data/repositories/user_repository.dart';
import 'domain/repositories/i_user_repository.dart';
import 'domain/use_case/user_usecase.dart';
import 'ui/controller/user_controller.dart';
import 'ui/my_app.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<List<Box>> _openBox() async {
  List<Box> boxList = [];
  await Hive.initFlutter();
  Hive.registerAdapter(UserDbAdapter());
  boxList.add(await Hive.openBox('userDb'));
  return boxList;
}

void main() {
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );

  Get.put<ILocalDataSource>(LocalDataSource());
  Get.put<IUserDataSource>(UserDataSource());
  Get.put<IUserRepository>(UserRepository(Get.find(), Get.find()));
  Get.put(UserUseCase(Get.find()));

  Get.put(Connectivity());
  Get.put(NetworkInfo(connectivity: Get.find()));
  Get.put(ConnectivityController());
  Get.put(UserController());
  runApp(const MyApp());
}
