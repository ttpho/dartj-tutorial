import 'dart:convert';

import 'package:app/base_response.dart';
import 'package:app/user.dart';
import 'package:app/user_repository.dart';
import 'package:http/http.dart' as http;

class HttpRequest implements UserRepository {
  @override
  Future<List<User>?> fetchUser() async {
    final response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    final parsed = json.decode(response.body);

    return BaseResponse.fromJson<List<User>?, User>(
      parsed,
      ((json) => User.fromJson(json)),
    );
  }
}
