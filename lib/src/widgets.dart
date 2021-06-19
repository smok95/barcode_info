import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import '../barcode_info.dart';

class BarcodeView extends StatelessWidget {
  final BarcodeInfo data;

  BarcodeView(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barcode = _getBarcode();
    final barcodeWidget = BarcodeWidget(data: data.code, barcode: barcode);
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Spacer(),
      AspectRatio(
          aspectRatio: _getBarcodeAspectRatio(),
          child: Card(
              child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(child: barcodeWidget)))),
      Spacer(),
    ]);
  }

  double _getBarcodeAspectRatio() {
    switch (data.format) {
      case BarcodeFormat.ean8:
        return 21.38 / 17.05;

      case BarcodeFormat.ean13:
        return 31.35 / 22.85;

      // 특별한 기준이 없는건 2:1로
      case BarcodeFormat.code39:
      case BarcodeFormat.code93:
      case BarcodeFormat.code128:
      case BarcodeFormat.codabar:
      case BarcodeFormat.itf:
        return 2 / 1;

      case BarcodeFormat.pdf417:
        return 2 / 1;

      case BarcodeFormat.aztec:
      case BarcodeFormat.dataMatrix:
      case BarcodeFormat.qrCode:
        return 1;

      case BarcodeFormat.upcA:
        return 37.29 / 25.91;

      case BarcodeFormat.upcE:
        return 22.11 / 25.91;

      default:
        return 1;
    }
  }

  Barcode _getBarcode() {
    switch (data.format) {
      case BarcodeFormat.aztec:
        return Barcode.aztec();

      case BarcodeFormat.codabar:
        return Barcode.codabar();

      case BarcodeFormat.code128:
        return Barcode.code128();

      case BarcodeFormat.code39:
        return Barcode.code39();

      case BarcodeFormat.code93:
        return Barcode.code93();

      case BarcodeFormat.dataMatrix:
        return Barcode.dataMatrix();

      case BarcodeFormat.ean8:
        return Barcode.ean8();

      case BarcodeFormat.ean13:
        return Barcode.ean13();

      case BarcodeFormat.itf:
        return Barcode.itf();

      case BarcodeFormat.pdf417:
        return Barcode.pdf417();

      case BarcodeFormat.qrCode:
        return Barcode.qrCode(
            errorCorrectLevel: BarcodeQRCorrectionLevel.quartile);

      case BarcodeFormat.upcA:
        return Barcode.upcA();

      case BarcodeFormat.upcE:
        return Barcode.upcE();

      default:
        // 지원하지 않는 포맷은 qrcode로 대체한다.
        return Barcode.qrCode(
            errorCorrectLevel: BarcodeQRCorrectionLevel.quartile);
    }
  }
}
