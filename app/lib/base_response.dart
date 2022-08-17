import 'package:app/user.dart';

class BaseResponse<T> {
  static T fromJson<T>(Object? json, String classNameItem) {
    if (json is Map<String, dynamic>) {
      if (classNameItem == (User).toString()) {
        return User.fromJson(json) as T;
      }
    }
    if (json is List) {
      if (classNameItem == (User).toString()) {
        return json
            .map((e) => User.fromJson(e as Map<String, dynamic>))
            .toList() as T;
      }
    }

    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.',
    );
  }
}
