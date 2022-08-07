import 'package:app/user.dart';

abstract class UserRepository {
  Future<List<User>?> fetchUser();
}
