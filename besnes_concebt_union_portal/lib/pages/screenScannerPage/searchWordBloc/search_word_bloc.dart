import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unionportal/models/models.dart';
import 'package:unionportal/repository/search_word_repository.dart';

part 'search_word_event.dart';
part 'search_word_state.dart';

class SearchWordBloc extends Bloc<SearchWordEvent, SearchWordState> {
  final SearchWordRepository repository;
  SearchWordBloc(this.repository) : super(SearchWordInitial());

  @override
  Stream<SearchWordState> mapEventToState(
    SearchWordEvent event,
  ) async* {
    if (event is SearchWord) {
      yield SearchWordLoading();
      try {
        final List<SearchWordModel> model =
            await repository.searchByWord(event.searchWord);

        yield SearchWordLoaded(model);
      } catch (error) {
        yield SearchWordError(error.toString());
      }
    }
  }
}
