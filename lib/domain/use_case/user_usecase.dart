import '../entities/user.dart';
import '../repositories/i_user_repository.dart';

class UserUseCase {
  final IUserRepository _repository;

  UserUseCase(this._repository);

  Future<List<User>> getUsers() async => await _repository.getUsers();

  Future<bool> addUser(User user) async => await _repository.addUser(user);

  Future<bool> updateUser(User user) async =>
      await _repository.updateUser(user);

  Future<bool> deleteUser(int id) async => await _repository.deleteUser(id);

  Future<void> deleteUsers() async => await _repository.deleteUsers();
}
