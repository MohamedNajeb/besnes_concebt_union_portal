part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {
  SearchLoading();
}

class SearchResultLoaded extends SearchState {
  final AdvancedSearchModel model;
  SearchResultLoaded(this.model);
}

class SearchResultError extends SearchState {
  final String errorMessage;
  SearchResultError(this.errorMessage);
}
