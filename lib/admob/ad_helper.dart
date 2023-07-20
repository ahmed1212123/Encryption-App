import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdHelper {

  static bool _testMode = true;
  static String get bannerAdUnitId{
    if(_testMode){
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return 'ca-app-pub-3606830706638300/4835463431';
  }
}