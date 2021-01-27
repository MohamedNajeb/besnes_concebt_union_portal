part of 'members_bloc.dart';

@immutable
abstract class MembersState {}

class MembersInitial extends MembersState {}

class MembersLoading extends MembersState {
  MembersLoading();
}

class MembersLoaded extends MembersState {
  final AllWorkMembersModel allMembersModel;
  MembersLoaded(this.allMembersModel);
}

class MembersError extends MembersState {
  final String errorMessage;
  MembersError(this.errorMessage);
}

class SingleMemberLoading extends MembersState {
  SingleMemberLoading();
}

class SingleMemberLoaded extends MembersState {
  final SingleWorkMemberModel singleMembersModel;
  SingleMemberLoaded(this.singleMembersModel);
}

class SingleMemberError extends MembersState {
  final String errorMessage;
  SingleMemberError(this.errorMessage);
}
