part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  SearchEvent();
}

class SimpleSearch extends SearchEvent {
  final String lang;
  final String searchWord;
  final int sectionId;
  final String fromDate;
  final String toDate;
  final int lastId;

  SimpleSearch(
    this.lang,
    this.searchWord,
    this.sectionId,
    this.fromDate,
    this.toDate,
    this.lastId,
  );
}
