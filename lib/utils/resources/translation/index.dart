import 'package:get/get.dart';

import 'en_US/index.dart';

class CasinoTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': EnUsTranslationStrings.allStrings,
  };
}
