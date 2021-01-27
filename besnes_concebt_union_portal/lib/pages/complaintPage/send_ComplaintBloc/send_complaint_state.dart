part of 'send_complaint_bloc.dart';

@immutable
abstract class SendComplaintState {}

class SendComplaintInitial extends SendComplaintState {}

class UserInput extends SendComplaintState {
  UserInput();
}
