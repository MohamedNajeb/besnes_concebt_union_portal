part of 'report_item_bloc.dart';

@immutable
abstract class ReportItemEvent {}

class PickImageFromGallery extends ReportItemEvent {
  PickImageFromGallery();
}

class PickImageFromCamera extends ReportItemEvent {
  PickImageFromCamera();
}

class SendButtonEvent extends ReportItemEvent {
  final BuildContext context;
  SendButtonEvent(this.context);
}
