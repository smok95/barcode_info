import 'barcode_base.dart';

class EAN13Info extends BarcodeInfo {
  EAN13Info(String code, this.prefix, {this.countryCodes})
      : super(BarcodeFormat.ean13, code);

  factory EAN13Info.fromCode(String code) {
    final prefix = code.substring(0, 3);
    final countryCodes = countriesFromGS1Prefix(prefix);

    return EAN13Info(code, prefix, countryCodes: countryCodes);
  }

  static bool isISBN(String prefix) {
    if (prefix.length != 3) return false;
    final code = int.tryParse(prefix);
    if (code == null) return false;
    // "Bookland" (ISBN) - 979-0 used for sheet music
    // ("Musicland", ISMN-13, replaces deprecated ISMN M-numbers)
    return (978 <= code && code <= 979);
  }

  /// GS1 prefix
  final String prefix;
  final Set<String>? countryCodes;
}

/// [GS1 Company Prefix](https://www.gs1.org/standards/id-keys/company-prefix)
/// https://en.wikipedia.org/wiki/List_of_GS1_country_codes
Set<String>? countriesFromGS1Prefix(final String prefix) {
  if (prefix.length != 3) return null;

  /// link : [https://en.wikipedia.org/wiki/List_of_GS1_country_codes]

  final code = int.tryParse(prefix);
  if (code == null) return null;

  /// description은 언어별로 다르게 표시해야하기 때문에 일단 링크만 설정하고
  /// 추후에 어떤값을 지정해야할지 고민한다.
  //String description =
  //    'https://en.wikipedia.org/wiki/List_of_GS1_country_codes';

  /// [https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2]
  /// 위 리스트에 없는 경우 국가명
  /// gs1 page와 wiki page의 정보가 약간 상이하다.
  /// 아래의 기준으로 작성됨.
  /// 1. wiki기준으로 작성
  /// 2. 국가가 2개 이상인 경우 gs1페이지 기준으로 1개 국가만 설정
  /// 3. gs1 page도 2개 국가 이상이면 그대로 설정
  final countries = Set<String>();

  if (0 <= code && code <= 19) {
    countries.addAll(['US']); //, 'CA']);
  } else if (20 <= code && code <= 29) {
    // Used to issue restricted circulation numbers within a geographic region
  } else if (30 <= code && code <= 39) {
    countries.add('US');
  } else if (40 <= code && code <= 49) {
    // Used to issue restricted circulation numbers within a geographic region
  } else if (50 <= code && code <= 59) {
    // GS1 US reserved for future use
  } else if (60 <= code && code <= 99) {
    countries.addAll(['US']); //, 'CA']);
  } else if (100 <= code && code <= 139) {
    countries.add('US');
  } else if (200 <= code && code <= 299) {
    // Used to issue restricted circulation numbers within a geographic region
  } else if (300 <= code && code <= 379) {
    countries.addAll(['FR']); //, 'MC']);
  } else if (code == 380) {
    countries.add('BG');
  } else if (code == 383) {
    countries.add('SI');
  } else if (code == 385) {
    countries.add('HR');
  } else if (code == 387) {
    countries.add('BA');
  } else if (code == 389) {
    countries.add('ME');
  } else if (code == 390) {
    countries.add('Kosovo');
  } else if (400 <= code && code <= 440) {
    countries.add('DE');
  } else if (450 <= code && code <= 459) {
    countries.add('JP');
  } else if (460 <= code && code <= 469) {
    countries.add('RU');
  } else if (code == 470) {
    countries.add('KG');
  } else if (code == 471) {
    countries.add('TW');
  } else if (code == 474) {
    countries.add('EE');
  } else if (code == 475) {
    countries.add('LV');
  } else if (code == 476) {
    countries.add('AZ');
  } else if (code == 477) {
    countries.add('LT');
  } else if (code == 478) {
    countries.add('UZ');
  } else if (code == 479) {
    countries.add('LK');
  } else if (code == 480) {
    countries.add('PH');
  } else if (code == 481) {
    countries.add('BY');
  } else if (code == 482) {
    countries.add('UA');
  } else if (code == 483) {
    countries.add('TM');
  } else if (code == 484) {
    countries.add('MD');
  } else if (code == 485) {
    countries.add('AM');
  } else if (code == 486) {
    countries.add('GE');
  } else if (code == 487) {
    countries.add('KZ');
  } else if (code == 488) {
    countries.add('TJ');
  } else if (code == 489) {
    countries.add('HK');
  } else if (490 <= code && code <= 499) {
    countries.add('JP');
  } else if (500 <= code && code <= 509) {
    countries.add('GB'); //'UK');
  } else if (520 <= code && code <= 521) {
    countries.add('GR');
  } else if (code == 528) {
    countries.add('LB');
  } else if (code == 529) {
    countries.add('CY');
  } else if (code == 530) {
    countries.add('AL');
  } else if (code == 531) {
    countries.add('MK');
  } else if (code == 535) {
    countries.add('MT');
  } else if (code == 539) {
    countries.add('IE');
  } else if (540 <= code && code <= 549) {
    countries.addAll(['BE', 'LU']);
  } else if (code == 560) {
    countries.add('PT');
  } else if (code == 569) {
    countries.add('IS');
  } else if (570 <= code && code <= 579) {
    countries.addAll(['DK']); //, 'FO', 'GL']);
  } else if (code == 590) {
    countries.add('PL');
  } else if (code == 594) {
    countries.add('RO');
  } else if (code == 599) {
    countries.add('HU');
  } else if (600 <= code && code <= 601) {
    countries.add('ZA');
  } else if (code == 603) {
    countries.add('GH');
  } else if (code == 604) {
    countries.add('SN');
  } else if (code == 608) {
    countries.add('BH');
  } else if (code == 609) {
    countries.add('MU');
  } else if (code == 611) {
    countries.add('MA');
  } else if (code == 613) {
    countries.add('DZ');
  } else if (code == 615) {
    countries.add('NG');
  } else if (code == 616) {
    countries.add('KE');
  } else if (code == 617) {
    countries.add('CM');
  } else if (code == 618) {
    countries.add('CI');
  } else if (code == 619) {
    countries.add('TN');
  } else if (code == 620) {
    countries.add('TZ');
  } else if (code == 621) {
    countries.add('SY');
  } else if (code == 622) {
    countries.add('EG');
  } else if (code == 623) {
    countries.add('BN');
  } else if (code == 624) {
    countries.add('LY');
  } else if (code == 625) {
    countries.add('JO');
  } else if (code == 626) {
    countries.add('IR');
  } else if (code == 627) {
    countries.add('KW');
  } else if (code == 628) {
    countries.add('SA');
  } else if (code == 629) {
    countries.add('AE');
  } else if (code == 630) {
    countries.add('QA');
  } else if (640 <= code && code <= 649) {
    countries.add('FI');
  } else if (690 <= code && code <= 699) {
    countries.add('CN');
  } else if (700 <= code && code <= 709) {
    countries.add('NO');
  } else if (code == 729) {
    countries.add('IL');
  } else if (730 <= code && code <= 739) {
    countries.add('SE');
  } else if (code == 740) {
    countries.add('GT');
  } else if (code == 741) {
    countries.add('SV');
  } else if (code == 742) {
    countries.add('HN');
  } else if (code == 743) {
    countries.add('NI');
  } else if (code == 744) {
    countries.add('CR');
  } else if (code == 745) {
    countries.add('PA');
  } else if (code == 746) {
    countries.add('DO');
  } else if (code == 750) {
    countries.add('MX');
  } else if (754 <= code && code <= 755) {
    countries.add('CA');
  } else if (code == 759) {
    countries.add('VE');
  } else if (760 <= code && code <= 769) {
    countries.addAll(['CH']); //, 'LI']);
  } else if (770 <= code && code <= 771) {
    countries.add('CO');
  } else if (code == 773) {
    countries.add('UY');
  } else if (code == 775) {
    countries.add('PE');
  } else if (code == 777) {
    countries.add('BO');
  } else if (778 <= code && code <= 779) {
    countries.add('AR');
  } else if (code == 780) {
    countries.add('CL');
  } else if (code == 784) {
    countries.add('PY');
  } else if (code == 786) {
    countries.add('EC');
  } else if (789 <= code && code <= 790) {
    countries.add('BR');
  } else if (800 <= code && code <= 839) {
    countries.addAll(['IT']); //, 'SM', 'VA']);
  } else if (840 <= code && code <= 849) {
    countries.addAll(['ES']); //, 'AD']);
  } else if (code == 850) {
    countries.add('CU');
  } else if (code == 858) {
    countries.add('SK');
  } else if (code == 859) {
    countries.add('CZ');
  } else if (code == 860) {
    countries.add('RS');
  } else if (code == 865) {
    countries.add('MN');
  } else if (code == 867) {
    countries.add('KP');
  } else if (868 <= code && code <= 869) {
    countries.add('TR');
  } else if (870 <= code && code <= 879) {
    countries.add('NL');
  } else if (code == 880) {
    countries.add('KR');
  } else if (code == 883) {
    countries.add('MM');
  } else if (code == 884) {
    countries.add('KH');
  } else if (code == 885) {
    countries.add('TH');
  } else if (code == 888) {
    countries.add('SG');
  } else if (code == 890) {
    countries.add('IN');
  } else if (code == 893) {
    countries.add('VN');
  } else if (code == 896) {
    countries.add('PK');
  } else if (code == 899) {
    countries.add('ID');
  } else if (900 <= code && code <= 919) {
    countries.add('AT');
  } else if (930 <= code && code <= 939) {
    countries.add('AU');
  } else if (940 <= code && code <= 949) {
    countries.add('NZ');
  } else if (code == 950) {
    // GS1 Global Office: Special applications
  } else if (code == 951) {
    // Used to issue General Manager Numbers for the EPC
    // General Identifier(GID) scheme as defined by EPC Tag Data Standard
  } else if (code == 952) {
    // Used for demonstrations and examples the GS1 system
  } else if (code == 955) {
    countries.add('MY');
  } else if (code == 958) {
    countries.add('MO');
  } else if (960 <= code && code <= 961) {
    // GS1 UK Office: GTIN-8 allocations
  } else if (962 <= code && code <= 969) {
    // GS1 Global Office: TGIN-8 allocations
  } else if (code == 977) {
    // Serial publications
  } else if (978 <= code && code <= 979) {
    // "Bookland" (ISBN) - 979-0 used for sheet music
    // ("Musicland", ISMN-13, replaces deprecated ISMN M-numbers)
  } else if (code == 980) {
    // Refund receipts
  } else if (981 <= code && code <= 984) {
    // GS1 coupon identification for common currency areas
  } else if (990 <= code && code <= 999) {
    // GS1 coupon identification
  }

  return countries;
}
