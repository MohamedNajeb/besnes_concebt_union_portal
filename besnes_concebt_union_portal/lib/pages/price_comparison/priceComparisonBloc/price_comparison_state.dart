part of 'price_comparison_bloc.dart';

@immutable
abstract class PriceComparisonState {}

class PriceComparisonInitial extends PriceComparisonState {}

class PriceComparisonLoading extends PriceComparisonState {}

class PriceComparisonLoaded extends PriceComparisonState {
  final List<GetByBarcodeModel> model;

  PriceComparisonLoaded(this.model);
}

class PriceComparisonError extends PriceComparisonState {
  final String error;

  PriceComparisonError(this.error);
}
