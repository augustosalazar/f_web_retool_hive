import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../data/core/network_info.dart';

class ConnectivityController extends GetxController {
  final connectvityResult = ConnectivityResult.none.obs;
  final NetworkInfo network = Get.find();
  final _connection = false.obs;

  bool get connection => _connection.value;

  @override
  Future onInit() async {
    super.onInit();
    // check for connectivity
    _connection.value = await network.isConnected();

    // listen to connectivity changed event and update connectvityResult value
    network.onConnectivityChanged.listen((event) {
      //connectvityResult.value = event;
      // automatically evoke remote fetch if device is offline
      // and articles data is empty, null or in local view

      bool isOnline = false;
      for (var item in event) {
        if (item != ConnectivityResult.none) {
          isOnline = true;
          break;
        }
      }

      _connection.value = isOnline;

      if (!isOnline) {
        logInfo("Device is offline");
      }
    });
  }

  @override
  void onClose() {
    // close subscriptions for rx values
    connectvityResult.close();
  }
}
