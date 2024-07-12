import 'package:at_planning/pages/login/data/login.type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class HomePage extends GetView {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final params = LoginParams.fromJson(Get.parameters);

    return Container(
      child: Text("this is home"),
    );
  }
}
