import 'package:f_web_retool_hive/data/models/user_db.dart';
import 'package:hive/hive.dart';
import 'package:loggy/loggy.dart';
import '../../../domain/entities/user.dart';
import 'i_local_data_source.dart';

class LocalDataSource implements ILocalDataSource {
  @override
  Future<List<User>> getCachedUsers() async {
    logInfo('getCachedUsers ${Hive.box('userDb').values.length}');
    return Hive.box('userDb')
        .values
        .map((entry) => User(
            id: entry.key,
            firstName: entry.firstName,
            lastName: entry.lastName,
            email: entry.email))
        .toList();
  }

  @override
  Future<void> deleteUsers() async {
    await Hive.box('userDb').clear();
    await Hive.box('userDbOffline').clear();
  }

  @override
  Future<void> deleteOfflineEntry(User entry) async {
    await Hive.box('userDbOffline').delete(entry.id);
  }

  @override
  Future<void> addOfflineUser(User entry) async {
    logInfo("Adding addOfflineUser");
    await Hive.box('userDbOffline').add(UserDb(
        firstName: entry.firstName,
        lastName: entry.lastName,
        email: entry.email));
    logInfo('addOfflineUser ${Hive.box('userDbOffline').values.length}');
  }

  @override
  Future<void> cacheUsers(List<User> users) async {
    logInfo('pre-cacheUsers ${Hive.box('userDb').values.length}');
    await Hive.box('userDb').clear();
    logInfo('pre-cacheUsers ${Hive.box('userDb').values.length}');
    for (var user in users) {
      await Hive.box('userDb').add(UserDb(
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email));
    }
    logInfo('cacheUsers ${Hive.box('userDb').values.length}');
  }

  @override
  Future<List<User>> getOfflineUsers() async {
    logInfo('getOfflineUsers ${Hive.box('userDbOffline').values.length}');
    return Hive.box('userDbOffline')
        .values
        .map((entry) => User(
            id: entry.key,
            firstName: entry.firstName,
            lastName: entry.lastName,
            email: entry.email))
        .toList();
  }

  @override
  Future<void> clearOfflineUsers() async {
    await Hive.box('userDbOffline').clear();
  }
}
