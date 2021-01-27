part of 'search_word_bloc.dart';

@immutable
abstract class SearchWordState {}

class SearchWordInitial extends SearchWordState {}

class SearchWordLoading extends SearchWordState {}

class SearchWordLoaded extends SearchWordState {
  final List<SearchWordModel> model;

  SearchWordLoaded(this.model);
}

class SearchWordError extends SearchWordState {
  final String error;

  SearchWordError(this.error);
}
