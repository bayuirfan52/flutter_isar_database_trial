import 'package:dio/dio.dart';
import 'package:isardb_trial/model/object_model.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

mixin DioHelper {
  static final _dio = Dio()..options = BaseOptions(
      baseUrl: 'https://api.restful-api.dev/'
  )..interceptors.add(PrettyDioLogger(
    responseBody: true,
  ));

  static Future<List<Object>?> getObject({int page = 1}) async {
    final response = await _dio.get('objects');
    final data = List<Object>.from(response.data.map((e) => Object.fromJson(e)).toList());
    return data;
  }
}