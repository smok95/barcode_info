import 'ean13_info.dart';
import 'isbn13_info.dart';
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
  isbn13,
}

abstract class BarcodeInfo {
  BarcodeInfo(this.format, this.code);

  /// Create BarcodeInfo
  ///
  /// [format] format string (ignore case)
  /// * BarcodeFormat string list
  ///   - aztec       : 'AZTEC'
  ///   - codabar     : 'CODABAR'
  ///   - code128     : 'CODE_128' or 'CODE128'
  ///   - code39      : 'CODE_39' or 'CODE39'
  ///   - code93      : 'CODE_93' or 'CODE93'
  ///   - dataMatrix  : 'DATA_MATRIX' or 'DATAMATRIX'
  ///   - ean8        : 'EAN_8' or 'EAN8'
  ///   - ean13       : 'EAN_13' or 'EAN13'
  ///   - itf         : 'ITF' or 'INTERLEAVED2OF5'
  ///   - maxicode    : 'MAXICODE'
  ///   - pdf417      : 'PDF_417' or 'PDF417'
  ///   - qrCode      : 'QR_CODE' or 'QR' or 'QRCODE'
  ///   - rss14       : 'RSS_14' or 'RSS14'
  ///   - upcA        : 'UPC_A' or 'UPCA'
  ///   - upcE        : 'UPC_E' or 'UPCE'
  ///   - isbn        : 'ISBN' or 'ISBN13'
  static BarcodeInfo create(final String format, String code) {
    final fmt = format.toUpperCase();
    if (fmt == 'AZTEC') {
      return AxtecInfo(code);
    } else if (fmt == 'CODABAR') {
      return CodabarInfo(code);
    } else if (fmt == 'CODE_128' || fmt == 'CODE128') {
      return Code128Info(code);
    } else if (fmt == 'CODE_39' || fmt == 'CODE39') {
      return Code39Info(code);
    } else if (fmt == 'CODE_93' || fmt == 'CODE93') {
      return Code93Info(code);
    } else if (fmt == 'DATA_MATRIX' || fmt == 'DATAMATRIX') {
      return DataMatrixInfo(code);
    } else if (fmt == 'EAN_8' || fmt == 'EAN8') {
      return Ean8Info(code);
    } else if (fmt == 'EAN_13' || fmt == 'EAN13') {
      var ean13 = EAN13Info.fromCode(code);
      if (EAN13Info.isISBN(ean13.prefix)) {
        return ISBN13Info.fromCode(code);
      }
      return ean13;
    } else if (fmt == 'ITF' || fmt == 'INTERLEAVED2OF5') {
      return ItfInfo(code);
    } else if (fmt == 'MAXICODE') {
      return MaxicodeInfo(code);
    } else if (fmt == 'PDF_417' || fmt == 'PDF417') {
      return Pdf417Info(code);
    } else if (fmt == 'QRCODE' || fmt == 'QR_CODE' || fmt == 'QR') {
      return QrCodeInfo.fromCode(code);
    } else if (fmt == 'RSS_14' || fmt == 'RSS14') {
      return Rss14Info(code);
    } else if (fmt == 'UPC_A' || fmt == 'UPCA') {
      return UPCAInfo(code);
    } else if (fmt == 'UPC_E' || fmt == 'UPCE') {
      return UPCEInfo(code);
    } else if (fmt == 'ISBN' || fmt == 'ISBN13') {
      return ISBN13Info.fromCode(code);
    } else {
      return BarcodeUnknown(code, format);
    }

    /// [https://zxing.github.io/zxing/apidocs/com/google/zxing/BarcodeFormat.html]
    /// EAN_13, UPC_A, QR_CODE, DATA_MATRIX, AZTEC, CODABAR, CODE_128, CODE_39
    /// CODE_93, EAN_8, ITF, MAXICODE, PDF_417, RSS_14, UPC_E
    ///
    ///  RSS_EXPANDED, UPC_EAN_EXTENSION
  }

  /// string format => 'format,code'
  /// example:
  ///   'ean13,8801051262995'
  factory BarcodeInfo.fromString(String value) {
    final idx = value.indexOf(',');
    if (idx <= 0 || idx >= value.length - 1) {
      throw FormatException('unexpected format.');
    }

    final format = value.substring(0, idx);
    final code = value.substring(idx + 1);

    return create(format, code);
  }

  /// BarcodeFormat
  final BarcodeFormat format;

  /// Barcode value
  final String code;

  String formatToString() {
    return format.toString().split('.').last;
  }

  @override
  String toString() {
    return formatToString() + ',' + code;
  }
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
