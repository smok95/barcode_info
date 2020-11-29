import 'package:tuple/tuple.dart';

import 'barcode_base.dart';

class QrCodeInfo extends BarcodeInfo {
  QrCodeInfo(String code) : super(BarcodeFormat.qrCode, code);

  static Future<QrCodeInfo> create(String code) async {
    var info = Lotto645QrCodeInfo.tryParse(code);
    if (info != null) return info;
    return QrCodeInfo(code);
  }
}

/// Lotto6/45 (Korean lottery game) QrCode format
class Lotto645QrCodeInfo extends QrCodeInfo {
  /// 추첨회차
  final int drawNo;

  /// 구매 게임 목록
  ///
  /// ```
  ///   [
  ///     {번호선택유형, {선택번호 6개}},
  ///     {번호선택유형, {선택번호 6개}},
  ///     ...
  ///   ]
  /// ```
  /// 번호선택유형 : 0-없음, 1-자동, 2-수동, 3-반자동
  final List<Tuple2<int, Set<int>>> games;

  /// TR번호
  final int trNumber;

  Lotto645QrCodeInfo(String code, this.drawNo, this.games, this.trNumber)
      : super(code);

  /// QrCode값이 로또6/45코드인지 확인
  ///
  /// 형식
  /// 복권수탁사업자url/?v=[0000][m/s/q/n][000000000000][m/s/q/n][000000000000][m/s/q/n][000000000000][m/s/q/n][000000000000][m/s/q/n][000000000000][0000000000]
  static Lotto645QrCodeInfo tryParse(final String code) {
    if (code == null || code.isEmpty) return null;

    // 로또6/45 수탁사업자 url여부 확인
    final baseUrls = [
      'http://qr.645lotto.net/?',
      'http://qr.nlotto.co.kr/?',
      'http://m.dhlottery.co.kr/?',
    ];

    var val = code;
    bool isLottoUrl = false;
    for (var baseUrl in baseUrls) {
      if (code.startsWith(baseUrl)) {
        isLottoUrl = true;
        val = code.substring(baseUrl.length);
        break;
      }
    }

    if (!isLottoUrl) return null;

    /// 데이터 길이 확인 (81자)
    /// http://m.dhlottery.co.kr/?v=0936m041720353943q071215303244m071113171829q010222253142m0414182731421050908394
    /// v=[0000][m/s/q/n][000000000000][m/s/q/n][000000000000][m/s/q/n][000000000000][m/s/q/n][000000000000][m/s/q/n][000000000000][0000000000]
    /// v= + 회차4자리 + (번호선택유형과 번호 13자리 * 5게임) + TR번호 10자리 = 총81자
    if (val.length != 81) return null;

    final drawNo = int.tryParse(val.substring(2, 6));
    if (drawNo == null) return null;
    val = val.substring(6);

    final games = List<Tuple2<int, Set<int>>>();
    for (var i = 0; i < 5; i++) {
      var s = val.substring(0, 13);
      val = val.substring(13);

      /// 번호선택유형
      var selectOption = 0;
      switch (s.substring(0, 1)) {
        case 'q':
          selectOption = 1;
          break;
        case 'm':
          selectOption = 2;
          break;
        case 's':
          selectOption = 3;
          break;
        default:
          continue;
      }

      s = s.substring(1);

      var lottoNumber = Set<int>();
      for (var j = 0; j < 6; j++) {
        final no = int.tryParse(s.substring(0, 2));
        if (no == null) return null;

        lottoNumber.add(no);
        s = s.substring(2);
      }

      games.add(Tuple2<int, Set<int>>(selectOption, lottoNumber));
    }

    final trNumber = int.tryParse(val);
    if (trNumber == null) return null;

    return Lotto645QrCodeInfo(code, drawNo, games, trNumber);
  }
}
