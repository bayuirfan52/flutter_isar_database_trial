import 'package:dio/dio.dart';
import 'package:isardb_trial/model/user_model.dart';

mixin DioHelper {
  static final _dio = Dio()..options = BaseOptions(
      baseUrl: 'https://reqres.in/'
  );

  static Future<List<Data>?> getUser() async {
    final response = await _dio.get('api/users?page=1');
    final data = Users.fromJson(response.data);
    return data.data;
  }
}