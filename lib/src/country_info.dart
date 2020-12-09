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
