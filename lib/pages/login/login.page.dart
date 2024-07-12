import 'package:at_planning/pages/home/home.page.dart';
import 'package:at_planning/pages/login/login.ctrl.dart';
import 'package:at_planning/utils/screen.util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  LoginPage({super.key});

  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController captchaCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.put(LoginController());
    return Scaffold(
      body: Container(
        width: SU.screenWidth,
        height: SU.screenHeight,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text("手机号"),
            TextField(
              controller: phoneCtrl,
              onChanged: (value) {
                ctrl.updatePhone(value);
              },
            ),
            Text("验证码"),
            TextField(
              controller: captchaCtrl,
              onChanged: (value) {
                ctrl.updateCaptcha(value);
              },
            ),
            RawMaterialButton(
              onPressed: () {
                Get.toNamed("/home");
              },
              child: Obx(() => Text("登录手机号${ctrl.phone}")),
            )
          ],
        ),
      ),
    );
  }
}
