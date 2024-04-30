import 'package:hive/hive.dart';

part 'user_db.g.dart';

//execute dart run build_runner build to generate the .g file

@HiveType(typeId: 1)
class UserDb extends HiveObject {
  UserDb({
    required this.firstName,
    required this.lastName,
    required this.email,
  });
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String lastName;
  @HiveField(2)
  String email;
}
