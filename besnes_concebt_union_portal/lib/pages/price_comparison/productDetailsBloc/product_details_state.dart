part of 'product_details_bloc.dart';

@immutable
abstract class ProductDetailsState {}

class ProductDetailsInitial extends ProductDetailsState {}

class ProductDetailsLoading extends ProductDetailsInitial {}

class ProductDetailsLoaded extends ProductDetailsInitial {
  final GetItemDetailsByBarcodeModel model;

  ProductDetailsLoaded(this.model);
}

class ProductDetailsError extends ProductDetailsInitial {
  final String error;

  ProductDetailsError(this.error);
}
