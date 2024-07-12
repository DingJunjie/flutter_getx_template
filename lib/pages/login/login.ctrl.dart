import 'dart:async';

import 'package:at_planning/pages/login/data/login.data.dart';
import 'package:get/get.dart';

const DEFAULT_REMAIN_TIME = 60;

class LoginController extends GetxController {
  final phone = "".obs;
  final captcha = "".obs;
  final type = LoginType.oneClick.obs;

  Timer? timer;
  final remainTime = 60.obs;

  updatePhone(String phoneInput) {
    phone(phoneInput);
  }

  updateCaptcha(String captchaInput) {
    captcha(captchaInput);
  }

  switchType(LoginType newType) {
    type(newType);
  }

  countingDown() {
    if (timer == null) {
      remainTime(DEFAULT_REMAIN_TIME);
      timer ??= Timer.periodic(const Duration(seconds: 1), (_) {
        final currentRemainTime = remainTime - 1;
        if (currentRemainTime <= 0) {
          timer?.cancel();
          timer = null;
          remainTime(0);
        }
      });
    }
  }
}
