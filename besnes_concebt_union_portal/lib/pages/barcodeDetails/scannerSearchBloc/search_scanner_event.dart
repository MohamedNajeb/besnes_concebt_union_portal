part of 'search_scanner_bloc.dart';

@immutable
abstract class SearchScannerEvent {}

class BarcodeDetails extends SearchScannerEvent {
  final String barcode;

  BarcodeDetails(this.barcode);
}
