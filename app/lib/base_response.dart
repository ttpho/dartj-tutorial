class BaseResponse<T, R> {
  static T fromJsonMore<T, R>(
    Object? json,
    R Function(Map<String, dynamic>) fromJson,
  ) {
    if (json is Map<String, dynamic>) {
      return fromJson.call(json) as T;
    }
    if (json is List) {
      return json.map((e) => fromJson.call(e as Map<String, dynamic>)).toList()
          as T;
    }

    throw ArgumentError.value(
      json,
      'json',
      'Cannot convert the provided data.',
    );
  }
}
