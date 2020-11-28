import 'package:flutter_localized_country_name/flutter_localized_country_name.dart';

import 'barcode_base.dart';
import 'country_info.dart';

class UPCAInfo extends BarcodeInfo {
  UPCAInfo(String code, {this.countries}) : super(BarcodeFormat.upcA, code);

  final List<CountryInfo> countries;

  static Future<UPCAInfo> create(String code) async {
    const countryCodes = ['US', 'CA'];

    List<CountryInfo> countries;
    if (countryCodes != null) {
      countries = await Future.wait(countryCodes.map((countryCode) async {
        final name = await FlutterLocalizedCountryName.getLocalizedCountryName(
            countryCode: countryCode);
        return CountryInfo(countryCode, name);
      }).toList());
    }

    return UPCAInfo(code, countries: countries);
  }
}
