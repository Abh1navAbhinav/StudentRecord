import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:project_student_record/screens/list.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    gotolist();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Lottie.asset('assets/images/106560-banana.json'),
      ),
    );
  }

  Future<void> gotolist() async {
    await Future.delayed(
      const Duration(seconds: 2),
    );

    // ignore: use_build_context_synchronously
    Get.offAll(ListScreen());
  }
}
