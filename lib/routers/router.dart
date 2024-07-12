import 'package:at_planning/pages/login/data/login.type.dart';
import 'package:at_planning/pages/not_found.page.dart';
import 'package:at_planning/pages/home/home.page.dart';
import 'package:at_planning/pages/login/login.page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routers {
  static GetPage unknownRoute =
      GetPage(name: "/notFound", page: () => PageNotFound());

  static List<GetPage> getPages = [
    GetPage(name: "/login", page: () => LoginPage()),
    GetPage(
        name: "/home",
        transition: Transition.cupertino,
        page: () => HomePage()),
  ];
}
