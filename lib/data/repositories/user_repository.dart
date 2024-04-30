import 'package:f_web_retool_hive/data/datasources/local/i_local_data_source.dart';

import '../../data/datasources/remote/user_datasource.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/i_user_repository.dart';
import '../datasources/remote/i_user_datasource.dart';

class UserRepository implements IUserRepository {
  final IUserDataSource _userDatatasource;
  final ILocalDataSource _localDataSource;

  UserRepository(this._userDatatasource, this._localDataSource);

  @override
  Future<List<User>> getUsers() async => await _userDatatasource.getUsers();

  @override
  Future<bool> addUser(User user) async =>
      await _userDatatasource.addUser(user);
  @override
  Future<bool> updateUser(User user) async =>
      await _userDatatasource.updateUser(user);
  @override
  Future<bool> deleteUser(int id) async =>
      await _userDatatasource.deleteUser(id);
}
