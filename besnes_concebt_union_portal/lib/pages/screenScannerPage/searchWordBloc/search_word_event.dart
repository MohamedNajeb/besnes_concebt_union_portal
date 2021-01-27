part of 'search_word_bloc.dart';

@immutable
abstract class SearchWordEvent {}

class SearchWord extends SearchWordEvent {
  final String searchWord;

  SearchWord(this.searchWord);
}
