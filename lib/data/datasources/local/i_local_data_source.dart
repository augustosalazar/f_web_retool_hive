import '../../../domain/entities/user.dart';

abstract class ILocalDataSource {
  Future<void> addOfflineUser(User entry);

  Future<List<User>> getUsers();

  Future<void> deleteAll();

  Future<void> deleteEntry(User entry);

  Future<void> cacheUsers(List<User> users);
}
