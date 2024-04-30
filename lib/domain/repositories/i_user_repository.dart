import '../../data/datasources/remote/i_user_datasource.dart';
import '../entities/user.dart';

abstract class IUserRepository {
  Future<List<User>> getUsers();

  Future<bool> addUser(User user);

  Future<bool> updateUser(User user);

  Future<bool> deleteUser(int id);
}
