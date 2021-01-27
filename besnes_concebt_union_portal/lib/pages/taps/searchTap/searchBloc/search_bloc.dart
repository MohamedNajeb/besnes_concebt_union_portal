import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unionportal/models/models.dart';
import 'package:unionportal/repository/search_repository.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchRepository repository;

  SearchBloc(this.repository) : super(SearchInitial());

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SimpleSearch) {
      yield SearchLoading();
      try {
        final AdvancedSearchModel searchModel =
            await repository.getBySearchWordRequest(
                event.lang,
                event.searchWord,
                event.sectionId,
                event.fromDate,
                event.toDate,
                event.lastId);
        yield SearchResultLoaded(searchModel);
      } catch (error) {
        yield SearchResultError(error.toString());
      }
    }
  }
}
