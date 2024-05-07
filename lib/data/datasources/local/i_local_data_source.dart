import '../../../domain/entities/user.dart';

abstract class ILocalDataSource {
  Future<void> addOfflineUser(User entry);

  Future<List<User>> getCachedUsers();

  Future<void> deleteAll();

  Future<void> deleteEntry(User entry);

  Future<void> cacheUsers(List<User> users);

  Future<List<User>> getOfflineUsers();

  Future<void> clearOfflineUsers();
}
