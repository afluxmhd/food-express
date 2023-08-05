import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_express/routes/route_helper.dart';

import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.white));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Express',
      initialRoute: RouteHelper.getInitial(0),
      getPages: RouteHelper.routes,
    );
  }
}
