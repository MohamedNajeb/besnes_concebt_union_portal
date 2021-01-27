part of 'price_comparison_bloc.dart';

@immutable
abstract class PriceComparisonEvent {}

class BarcodeComparisonDetails extends PriceComparisonEvent {
  final String qrCodeResult;

  BarcodeComparisonDetails(this.qrCodeResult);
}
