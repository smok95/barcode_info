import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

import '../barcode_info.dart';

class BarcodeView extends StatelessWidget {
  final BarcodeInfo data;

  BarcodeView(this.data, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barcode = _getBarcode();
    final barcodeWidget = barcode != null
        ? BarcodeWidget(data: data.code, barcode: barcode)
        : Text('Unsupported barcode');
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
        break;
      case BarcodeFormat.ean13:
        return 31.35 / 22.85;
        break;
      // 특별한 기준이 없는건 2:1로
      case BarcodeFormat.code39:
      case BarcodeFormat.code93:
      case BarcodeFormat.code128:
      case BarcodeFormat.codabar:
      case BarcodeFormat.itf:
        return 2 / 1;
        break;
      case BarcodeFormat.pdf417:
        return 2 / 1;
        break;
      case BarcodeFormat.aztec:
      case BarcodeFormat.dataMatrix:
      case BarcodeFormat.qrCode:
        return 1;
        break;
      case BarcodeFormat.upcA:
        return 37.29 / 25.91;
        break;
      case BarcodeFormat.upcE:
        return 22.11 / 25.91;
        break;
      default:
        return 1;
    }
  }

  Barcode _getBarcode() {
    switch (data.format) {
      case BarcodeFormat.aztec:
        return Barcode.aztec();
        break;
      case BarcodeFormat.codabar:
        return Barcode.codabar();
        break;
      case BarcodeFormat.code128:
        return Barcode.code128();
        break;
      case BarcodeFormat.code39:
        return Barcode.code39();
        break;
      case BarcodeFormat.code93:
        return Barcode.code93();
        break;
      case BarcodeFormat.dataMatrix:
        return Barcode.dataMatrix();
        break;
      case BarcodeFormat.ean8:
        return Barcode.ean8();
        break;
      case BarcodeFormat.ean13:
        return Barcode.ean13();
        break;
      case BarcodeFormat.itf:
        return Barcode.itf();
        break;
      case BarcodeFormat.pdf417:
        return Barcode.pdf417();
        break;
      case BarcodeFormat.qrCode:
        return Barcode.qrCode(
            errorCorrectLevel: BarcodeQRCorrectionLevel.quartile);
        break;
      case BarcodeFormat.upcA:
        return Barcode.upcA();
        break;
      case BarcodeFormat.upcE:
        return Barcode.upcE();
        break;
      default:
        // 지원하지 않는 포맷은 qrcode로 대체한다.
        return Barcode.qrCode(
            errorCorrectLevel: BarcodeQRCorrectionLevel.quartile);
    }
  }
}
