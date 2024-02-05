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
}
