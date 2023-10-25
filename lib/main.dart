import 'package:casino/config/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'config/router/page.dart';
import 'utils/resources/translation/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color.fromARGB(255, 0, 0, 0), // navigation bar color
    statusBarColor: Color.fromARGB(255, 0, 0, 0), // status bar color
  ));
  runApp(const Casino());
}

class Casino extends StatefulWidget {
  const Casino({super.key});

  @override
  State<Casino> createState() => _CasinoState();
}

class _CasinoState extends State<Casino> {
  @override

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Center(
        child: child!,
      ),
      title: 'Casino',
      defaultTransition: Transition.rightToLeft,
      translations: CasinoTranslations(),
      locale: const Locale('en', 'EN'),
      getPages: AppPages.pages,
      initialRoute: Routes.splash,
    );
  }
}

