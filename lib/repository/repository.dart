import 'package:isar/isar.dart';
import 'package:isardb_trial/helper/dio_helper.dart';
import 'package:isardb_trial/model/user_model.dart';

import '../main.dart';

class Repository {
  Future<List<Data>> getUser({int page = 1}) async {
    final isar = getIt<Isar>();

    final dbData = await isar.datas.where().findAll();
    final data = <Data>[];
    if (dbData.isEmpty) {
      final response = await DioHelper.getUser(page: page);
      if (response != null) {
        data.addAll(response);
        await isar.writeTxn(() {
          return isar.datas.putAll(data);
        });
      }
    } else {
      data.addAll(dbData);
    }
    return data;
  }
}
