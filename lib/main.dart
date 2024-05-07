import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:f_web_retool_hive/data/datasources/local/i_local_data_source.dart';
import 'package:f_web_retool_hive/data/models/user_db.dart';
import 'package:f_web_retool_hive/ui/controller/connectivity_controller.dart';
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
import 'package:path_provider/path_provider.dart';

Future<List<Box>> _openBox() async {
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  List<Box> boxList = [];
  await Hive.initFlutter();
  Hive.registerAdapter(UserDbAdapter());
  boxList.add(await Hive.openBox('userDb'));
  boxList.add(await Hive.openBox('userDbOffline'));
  logInfo("Box opened userDb ${await Hive.boxExists('userDb')}");
  logInfo("Box opened userDbOffline ${await Hive.boxExists('userDbOffline')}");
  return boxList;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  await _openBox();
  Get.put(NetworkInfo());
  Get.put<ILocalDataSource>(LocalDataSource());
  Get.put<IUserDataSource>(UserDataSource());
  Get.put<IUserRepository>(UserRepository(Get.find(), Get.find(), Get.find()));
  Get.put(UserUseCase(Get.find()));

  Get.put(ConnectivityController());
  Get.put(UserController());
  runApp(const MyApp());
}
