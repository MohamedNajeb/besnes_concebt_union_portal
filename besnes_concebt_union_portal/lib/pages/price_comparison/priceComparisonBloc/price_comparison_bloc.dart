import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unionportal/models/models.dart';
import 'package:unionportal/repository/price_comparison_repository.dart';

part 'price_comparison_event.dart';
part 'price_comparison_state.dart';

class PriceComparisonBloc
    extends Bloc<PriceComparisonEvent, PriceComparisonState> {
  final PriceComparisonRepository repository;
  PriceComparisonBloc(this.repository) : super(PriceComparisonInitial());

  @override
  Stream<PriceComparisonState> mapEventToState(
    PriceComparisonEvent event,
  ) async* {
    if (event is BarcodeComparisonDetails) {
      yield PriceComparisonLoading();
      try {
        final List<GetByBarcodeModel> model =
            await repository.getItemByBarcode(event.qrCodeResult);

        yield PriceComparisonLoaded(model);
      } catch (error) {
        yield PriceComparisonError(error.toString());
      }
    }
  }
}
