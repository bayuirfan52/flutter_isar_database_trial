import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:isar/isar.dart';
import 'package:isardb_trial/helper/dio_helper.dart';
import 'package:isardb_trial/model/object_model.dart';

import '../main.dart';

class Repository {
  Future<List<Object>> getObject({int page = 1}) async {
    final isar = getIt<Isar>();

    final dbData = await isar.objects.where().findAll();
    final data = <Object>[];
    if (dbData.isEmpty) {
      final response = await DioHelper.getObject(page: page);
      if (response != null) {
        data.addAll(response);
        await isar.writeTxn(() {
          return isar.objects.putAll(data);
        });
      }
    } else {
      data.addAll(dbData);
    }
    return data;
  }

  Future<Object> getObjectById(String id) async {
    final isar = getIt<Isar>();

    var data = Object();
    var isConnected = await InternetConnection.createInstance().hasInternetAccess;
    if (isConnected) {
      final response = await DioHelper.getObjectById(id);
      if (response != null) {
        data =  response;
        await isar.writeTxn(() {
          return isar.objects.put(data);
        });
      }
    } else {
      final result = await isar.objects.where().filter().idEqualTo(id).findFirst();
      if (result != null) {
        data = result;
      }
    }
    return data;
  }
}
