import 'package:f_web_retool_hive/data/datasources/local/i_local_data_source.dart';
import 'package:loggy/loggy.dart';

import '../datasources/remote/remote_user_source.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/i_user_repository.dart';
import '../core/network_info.dart';
import '../datasources/remote/i_remote_user_source.dart';

class UserRepository implements IUserRepository {
  final IRemoteUserSource _userDatatasource;
  final ILocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  UserRepository(
      this._userDatatasource, this._localDataSource, this._networkInfo);

  @override
  Future<List<User>> getUsers() async {
    if (await _networkInfo.isConnected()) {
      logInfo("getUsers online");
      // Get offline users and add them to the backend
      final offLineUsers = await _localDataSource.getOfflineUsers();
      if (offLineUsers.isNotEmpty) {
        logInfo("getUsers found ${offLineUsers.length} offline users");
        for (var user in offLineUsers) {
          var rta = await _userDatatasource.addUser(user);
          if (rta) {
            await _localDataSource.deleteOfflineEntry(user);
          } else {
            logError("getUsers error adding offline user");
          }
        }
      }
      // Get users from backend
      final users = await _userDatatasource.getUsers();
      logInfo("getUsers online users: ${users.length}");
      await _localDataSource.cacheUsers(users);
      return users;
    }
    // Get offline users
    logInfo("getUsers offline");
    return await _localDataSource.getCachedUsers() +
        await _localDataSource.getOfflineUsers();
  }

  @override
  Future<bool> addUser(User user) async {
    if (await _networkInfo.isConnected()) {
      await _userDatatasource.addUser(user);
    } else {
      await _localDataSource.addOfflineUser(user);
    }
    return true;
  }

  @override
  Future<bool> updateUser(User user) async {
    if (await _networkInfo.isConnected()) {
      await _userDatatasource.updateUser(user);
    } else {
      return false;
    }
    return true;
  }

  @override
  Future<bool> deleteUser(int id) async {
    if (await _networkInfo.isConnected()) {
      await _userDatatasource.deleteUser(id);
    } else {
      return false;
    }
    return true;
  }

  @override
  Future<void> deleteUsers() async {
    await _localDataSource.deleteUsers();
    if (await _networkInfo.isConnected()) {
      await _userDatatasource.deleteUsers();
    }
  }
}
