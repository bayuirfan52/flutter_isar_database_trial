
import 'package:auto_route/auto_route.dart';
import 'package:isardb_trial/pages/detail_page.dart';
import 'package:isardb_trial/pages/main_page.dart';

part 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: MainRoute.page, initial: true),
    AutoRoute(page: DetailRoute.page),
  ];
}