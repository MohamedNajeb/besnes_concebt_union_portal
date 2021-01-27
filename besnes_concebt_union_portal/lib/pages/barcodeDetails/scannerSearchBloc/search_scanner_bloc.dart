import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:unionportal/models/models.dart';
import 'package:unionportal/repository/barcode_details_repository.dart';

part 'search_scanner_event.dart';

part 'search_scanner_state.dart';

class SearchScannerBloc extends Bloc<SearchScannerEvent, SearchScannerState> {
  final BarcodeDetailsRepository repository;

  SearchScannerBloc(this.repository) : super(SearchScannerInitial());

  @override
  Stream<SearchScannerState> mapEventToState(
    SearchScannerEvent event,
  ) async* {
    yield SearchScannerLoading();
    if (event is BarcodeDetails) {
      try {
        final List<BarcodeModel> listModel =
            await repository.getBarcodeItem(event.barcode);

        if (listModel.isEmpty) {
          yield SearchScannerError("لا يوجد بيانات خاصة بالمنتج");
        } else {
          yield SearchScannerLoaded(listModel);
        }
      } catch (error) {
        yield SearchScannerError(error.toString());
      }
    }
  }
}
