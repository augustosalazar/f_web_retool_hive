import '../../../domain/entities/user.dart';

abstract class IRemoteUserSource {
  Future<List<User>> getUsers();

  Future<bool> addUser(User user);

  Future<bool> updateUser(User user);

  Future<bool> deleteUser(int id);

  Future<bool> deleteUsers();
}
