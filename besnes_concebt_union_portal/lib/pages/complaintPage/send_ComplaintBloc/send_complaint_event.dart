part of 'send_complaint_bloc.dart';

@immutable
abstract class SendComplaintEvent {}

class SendButtonEvent extends SendComplaintEvent {
  final BuildContext context;
  SendButtonEvent(this.context);
}
