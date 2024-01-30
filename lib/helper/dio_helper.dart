import 'package:dio/dio.dart';
import 'package:isardb_trial/model/user_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

mixin DioHelper {
  static final _dio = Dio()..options = BaseOptions(
      baseUrl: 'https://reqres.in/'
  )..interceptors.add(PrettyDioLogger(
    responseBody: true,
  ));

  static Future<List<Data>?> getUser({int page = 1}) async {
    final response = await _dio.get('api/users?page=$page');
    final data = Users.fromJson(response.data);
    return data.data;
  }
}