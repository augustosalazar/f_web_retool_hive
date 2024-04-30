import '../../../domain/entities/user.dart';

abstract class ILocalDataSource {
  Future<void> addEntry(User entry);

  Future<List<User>> getAll();

  Future<void> deleteAll();

  Future<void> deleteEntry(User entry);
}
