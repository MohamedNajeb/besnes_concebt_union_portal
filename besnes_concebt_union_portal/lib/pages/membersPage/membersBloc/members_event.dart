part of 'members_bloc.dart';

@immutable
abstract class MembersEvent {}

class FetchMembersData extends MembersEvent {
  FetchMembersData();
}

class FetchMemberDetails extends MembersEvent {
  final int memberId;

  FetchMemberDetails(this.memberId);
}
