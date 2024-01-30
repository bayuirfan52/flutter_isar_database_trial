import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:isardb_trial/model/user_model.dart';
import 'package:isardb_trial/pages/main_page.dart';
import 'package:path_provider/path_provider.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationSupportDirectory();
  final isar = await Isar.open([DataSchema], directory: dir.path);
  getIt.registerSingleton<Isar>(isar);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade500),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
