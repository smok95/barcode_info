import 'ean13_info.dart';
import 'qrcode_info.dart';
import 'upca_info.dart';

export 'ean13_info.dart';
export 'upca_info.dart';

enum BarcodeFormat {
  unknown,
  aztec,
  codabar,
  code128,
  code39,
  code93,
  dataMatrix,
  ean8,
  ean13,
  itf,
  maxicode,
  pdf417,
  qrCode,
  rss14,
  upcA,
  upcE,
}

abstract class BarcodeInfo {
  BarcodeInfo(this.format, this.code);

  static Future<BarcodeInfo> create(String format, String code) async {
    if (format == 'EAN_13') {
      return await EAN13Info.create(code);
    } else if (format == 'UPC_A') {
      return await UPCAInfo.create(code);
    } else if (format == 'QR_CODE') {
      return await QrCodeInfo.create(code);
    } else if (format == 'DATA_MATRIX') {
      return DataMatrixInfo(code);
    } else if (format == 'AZTEC') {
      return AxtecInfo(code);
    } else if (format == 'CODABAR') {
      return CodabarInfo(code);
    } else if (format == 'CODE_128') {
      return Code128Info(code);
    } else if (format == 'CODE_39') {
      return Code39Info(code);
    } else if (format == 'CODE_93') {
      return Code93Info(code);
    } else if (format == 'EAN_8') {
      return Ean8Info(code);
    } else if (format == 'ITF') {
      return ItfInfo(code);
    } else if (format == 'MAXICODE') {
      return MaxicodeInfo(code);
    } else if (format == 'PDF_417') {
      return Pdf417Info(code);
    } else if (format == 'RSS_14') {
      return Rss14Info(code);
    } else if (format == 'UPC_E') {
      return UPCEInfo(code);
    } else {
      return BarcodeUnknown(code, format);
    }

    /// [https://zxing.github.io/zxing/apidocs/com/google/zxing/BarcodeFormat.html]
    /// EAN_13, UPC_A, QR_CODE, DATA_MATRIX, AZTEC, CODABAR, CODE_128, CODE_39
    /// CODE_93, EAN_8, ITF, MAXICODE, PDF_417, RSS_14, UPC_E
    ///
    ///  RSS_EXPANDED, UPC_EAN_EXTENSION
  }

  /// BarcodeFormat
  final BarcodeFormat format;

  /// Barcode value
  final String code;
}

class BarcodeUnknown extends BarcodeInfo {
  BarcodeUnknown(String code, this.formatText)
      : super(BarcodeFormat.unknown, code);

  final String formatText;
}

class DataMatrixInfo extends BarcodeInfo {
  DataMatrixInfo(String code) : super(BarcodeFormat.dataMatrix, code);
}

class AxtecInfo extends BarcodeInfo {
  AxtecInfo(String code) : super(BarcodeFormat.aztec, code);
}

class CodabarInfo extends BarcodeInfo {
  CodabarInfo(String code) : super(BarcodeFormat.codabar, code);
}

class Code128Info extends BarcodeInfo {
  Code128Info(String code) : super(BarcodeFormat.code128, code);
}

class Code39Info extends BarcodeInfo {
  Code39Info(String code) : super(BarcodeFormat.code39, code);
}

class Code93Info extends BarcodeInfo {
  Code93Info(String code) : super(BarcodeFormat.code93, code);
}

class Ean8Info extends BarcodeInfo {
  Ean8Info(String code) : super(BarcodeFormat.ean8, code);
}

class ItfInfo extends BarcodeInfo {
  ItfInfo(String code) : super(BarcodeFormat.itf, code);
}

class MaxicodeInfo extends BarcodeInfo {
  MaxicodeInfo(String code) : super(BarcodeFormat.maxicode, code);
}

class Pdf417Info extends BarcodeInfo {
  Pdf417Info(String code) : super(BarcodeFormat.pdf417, code);
}

class Rss14Info extends BarcodeInfo {
  Rss14Info(String code) : super(BarcodeFormat.rss14, code);
}

class UPCEInfo extends BarcodeInfo {
  UPCEInfo(String code) : super(BarcodeFormat.upcE, code);
}
