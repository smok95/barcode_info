/*

2021-06-19 flutter_localized_country_name 패키지가 null safety를 지원하지 않아 
그냥 barcode_info에서 CountryInfo 를 삭제함.
필요한 경우에는 개별 구현하는 방식으로 하는게 좋을 것 같아서...

import 'package:flutter_localized_country_name/flutter_localized_country_name.dart';

class CountryInfo {
  CountryInfo(this.code, this.name);

  /// country code
  /// ISO 3166-1 alpha-2:[https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2]
  final String code;

  /// country name
  final String name;

  static Future<CountryInfo> create(String countryCode) async {
    final name = await FlutterLocalizedCountryName.getLocalizedCountryName(
        countryCode: countryCode);
    return CountryInfo(countryCode, name);
  }
}
*/