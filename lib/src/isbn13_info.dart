import 'barcode_base.dart';

class ISBN13Info extends BarcodeInfo {
  ISBN13Info(String code, this.ean, this.group, this.publisher, this.title,
      this.checkDigit)
      : super(BarcodeFormat.isbn13, code);

  factory ISBN13Info.fromCode(String code) {
    int ean = 0;
    int group = 0;
    int publisher = 0;
    int title = 0;
    int checkDigit = 0;
    if (code.length == 13) {
      ean = int.tryParse(code.substring(0, 3)) ?? 0;
      group = int.tryParse(code.substring(3, 5)) ?? 0;
      publisher = int.tryParse(code.substring(5, 9)) ?? 0;
      title = int.tryParse(code.substring(9, 12)) ?? 0;
      checkDigit = int.tryParse(code.substring(12, 13)) ?? 0;
    }
    return ISBN13Info(code, ean, group, publisher, title, checkDigit);
  }

  /// https://en.wikipedia.org/wiki/ISBN
  final int ean;
  final int group;
  final int publisher;
  final int title;
  final int checkDigit;
}
