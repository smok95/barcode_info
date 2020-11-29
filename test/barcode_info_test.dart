import 'package:barcode_info/src/qrcode_info.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:barcode_info/barcode_info.dart';

void main() {
  test('로또6/45 QRCode parsing', () async {
    const code =
        'http://m.dhlottery.co.kr/?v=0936m041720353943q071215303244m071113171829q010222253142m0414182731421050908394';
    final BarcodeInfo barcode = await BarcodeInfo.create('QR_CODE', code);
    expect(barcode is Lotto645QrCodeInfo, true);
    final lottocode = barcode as Lotto645QrCodeInfo;
    expect(lottocode.drawNo, 936);
    expect(lottocode.games.length, 5);

    expect(lottocode.games[0].item1, 2);
    expect(lottocode.games[0].item2, equals([4, 17, 20, 35, 39, 43]));

    expect(lottocode.games[1].item1, 1);
    expect(lottocode.games[1].item2, equals([7, 12, 15, 30, 32, 44]));

    expect(lottocode.games[2].item1, 2);
    expect(lottocode.games[2].item2, equals([7, 11, 13, 17, 18, 29]));

    expect(lottocode.games[3].item1, 1);
    expect(lottocode.games[3].item2, equals([1, 2, 22, 25, 31, 42]));

    expect(lottocode.games[4].item1, 2);
    expect(lottocode.games[4].item2, equals([4, 14, 18, 27, 31, 42]));

    expect(lottocode.trNumber, 1050908394);
  });
}
