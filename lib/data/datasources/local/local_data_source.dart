import 'package:f_web_retool_hive/data/models/user_db.dart';
import 'package:hive/hive.dart';
import 'package:loggy/loggy.dart';
import '../../../domain/entities/user.dart';
import 'i_local_data_source.dart';

class LocalDataSource implements ILocalDataSource {
  @override
  Future<List<User>> getCachedUsers() async {
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
  Future<void> deleteAll() async {
    await Hive.box('userDb').clear();
  }

  @override
  Future<void> deleteEntry(User entry) async {
    await Hive.box('userDb').delete(entry.id);
  }

  @override
  Future<void> addOfflineUser(User entry) async {
    logInfo("Adding addOfflineUser");
    Hive.box('userDbOffline').add(UserDb(
        firstName: entry.firstName,
        lastName: entry.lastName,
        email: entry.email));
  }

  @override
  Future<void> cacheUsers(List<User> users) async {
    Hive.box('userDb').clear();
    for (var user in users) {
      await Hive.box('userDb').add(UserDb(
          firstName: user.firstName,
          lastName: user.lastName,
          email: user.email));
    }
  }

  @override
  Future<List<User>> getOfflineUsers() async {
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
    Hive.box('userDbOffline').clear();
  }
}
