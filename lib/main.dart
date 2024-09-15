import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kacs/controllers/navigation/routes.dart';
import 'package:kacs/utils/scroll_behavior.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  await GetStorage.init();
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(),
          initialRoute: Routes.determineInitialRoute(),
          getPages: Routes.pages,
          builder: FToastBuilder(),
          navigatorKey: navigatorKey,
          scrollBehavior: UtilScrollBehavior(),
        );
      },
    ),
  );
}
