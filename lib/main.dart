import 'package:cafedating/global.dart';
import 'package:cafedating/routers/app_router.dart';
import 'package:cafedating/routers/route_map.dart';
import 'package:cafedating/services/app_dio.dart';
import 'package:cafedating/services/notification_service.dart';
import 'package:cafedating/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  await Global.init();
  AppDio();
  await NotificationService.instance.initialize();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkModeAppTheme,
      routes: routeMap,
      onGenerateRoute: AppRouter.generateRouteSettings,
      navigatorKey: navigatorKey, // important
    );
  }
}
