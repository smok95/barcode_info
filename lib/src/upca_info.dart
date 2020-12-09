import 'barcode_base.dart';

class UPCAInfo extends BarcodeInfo {
  UPCAInfo(String code) : super(BarcodeFormat.upcA, code);
  final Set<String> countryCodes = {'US', 'CA'};
}
