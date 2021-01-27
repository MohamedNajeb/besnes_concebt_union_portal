import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unionportal/models/getItem_details_by_barcode_model.dart';
import 'package:unionportal/repository/product_details_repository.dart';

part 'product_details_event.dart';
part 'product_details_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  final ProductDetailsRepository repository;
  ProductDetailsBloc(this.repository) : super(ProductDetailsInitial());

  @override
  Stream<ProductDetailsState> mapEventToState(
    ProductDetailsEvent event,
  ) async* {
    if (event is ProductDetails) {
      yield ProductDetailsLoading();
      try {
        final GetItemDetailsByBarcodeModel model =
            await repository.getItemDetailsByBarcodeModel(event.itemBarcode);

        yield ProductDetailsLoaded(model);
      } catch (error) {
        yield ProductDetailsError(error.toString());
      }
    }
  }
}
