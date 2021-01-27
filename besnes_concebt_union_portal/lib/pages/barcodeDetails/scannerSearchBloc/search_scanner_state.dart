part of 'search_scanner_bloc.dart';

@immutable
abstract class SearchScannerState {}

class SearchScannerInitial extends SearchScannerState {}

class SearchScannerLoading extends SearchScannerState {
  SearchScannerLoading();
}

class SearchScannerLoaded extends SearchScannerState {
  final List<BarcodeModel> modelList;
  SearchScannerLoaded(this.modelList);
}

class SearchScannerError extends SearchScannerState {
  final String errorMessage;
  SearchScannerError(this.errorMessage);
}
