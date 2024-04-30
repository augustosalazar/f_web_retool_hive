import 'package:f_web_retool_hive/data/models/user_db.dart';
import 'package:hive/hive.dart';
import 'package:loggy/loggy.dart';
import '../../../domain/entities/user.dart';
import 'i_local_data_source.dart';

class LocalDataSource implements ILocalDataSource {
  @override
  Future<void> addEntry(User entry) async {
    logInfo("Adding entry to db");
    Hive.box('userDb').add(UserDb(
        firstName: entry.firstName,
        lastName: entry.lastName,
        email: entry.email));
  }

  @override
  Future<List<User>> getAll() async {
    return Hive.box('userDb')
        .values
        .map((entry) => User(
            id: entry.key,
            firstName: entry.name,
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
}