part of 'report_item_bloc.dart';

@immutable
abstract class ReportItemState {}

class ReportItemInitial extends ReportItemState {}

class ImagePicked extends ReportItemState {
  ImagePicked();
}

class UserInputError extends ReportItemState {
  UserInputError();
}

class ReportSentSuccessfully extends ReportItemState {
  ReportSentSuccessfully();
}
