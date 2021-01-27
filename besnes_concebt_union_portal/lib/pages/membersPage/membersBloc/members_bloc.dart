import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:unionportal/models/models.dart';
import 'package:unionportal/repository/members_repository.dart';

part 'members_event.dart';

part 'members_state.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  final MembersRepository repository;

  MembersBloc(this.repository) : super(MembersInitial());

  AllWorkMembersModel _allWorkersModel;
  SingleWorkMemberModel _singleWorkerModel;

  AllWorkMembersModel get allMembersModel => _allWorkersModel;

  SingleWorkMemberModel get singleMemberModel => _singleWorkerModel;

  @override
  Stream<MembersState> mapEventToState(
    MembersEvent event,
  ) async* {
    yield MembersLoading();
    if (event is FetchMembersData) {
      try {
        _allWorkersModel = await repository.getAllWorkMembers();

        yield MembersLoaded(_allWorkersModel);
      } catch (error) {
        yield MembersError(error.toString());
      }
    } else if (event is FetchMemberDetails) {
      try {
        _singleWorkerModel =
            await repository.getSingleWorkMember("ar", event.memberId);

        yield SingleMemberLoaded(_singleWorkerModel);
      } catch (error) {
        yield SingleMemberError(error.toString());
      }
    }
  }
}
