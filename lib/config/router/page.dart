import 'package:casino/global_widgets/pg.dart';
import 'package:casino/presentation/create_invoice/index.dart';
import 'package:casino/presentation/home/binding.dart';
import 'package:casino/presentation/home/page.dart';
import 'package:casino/presentation/login/binding.dart';
import 'package:casino/presentation/splash/binding.dart';
import 'package:casino/presentation/splash/page.dart';
import 'package:casino/presentation/user_login/page.dart';
import 'package:casino/presentation/verification/binding.dart';
import 'package:casino/presentation/verification/page.dart';
import 'package:get/get.dart';
import '../../presentation/create_invoice/binding.dart';
import '../../presentation/login/page.dart';
import '../../presentation/payment/binding.dart';
import '../../presentation/user_login/binding.dart';
import 'routes.dart';

abstract class AppPages {
  static final List<GetPage<dynamic>> pages = [
    GetPage(
      name: Routes.splash,
      page: () => const Splash(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.loginUser,
      page: () => const UserLogin(),
      binding: UserBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.verification,
      page: () => const Verification(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: Routes.items,
      page: () => const Items(),
      binding: ItemsBinding(),
    ),
    GetPage(
      name: Routes.invoice,
      page: () => const Invoice(),
      binding: InvoiceBinding(),
    ),
    GetPage(
      name: Routes.payment,
      page: () => const Payment(),
      binding: PaymentBinding(),
    ),
    ];
}
