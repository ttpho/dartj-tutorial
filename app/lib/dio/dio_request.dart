import 'package:app/user.dart';
import 'package:app/user_repository.dart';
import 'package:dio/dio.dart';

class DioRequest implements UserRepository {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://jsonplaceholder.typicode.com/",
      responseType: ResponseType.json,
      receiveTimeout: 3000,
    ),
  );

  @override
  Future<List<User>?> fetchUser() async {
    final Response<List<dynamic>> response = await _dio.get("/users");
    return response.data?.map((e) => User.fromJson(e)).toList(growable: false);
  }
}
