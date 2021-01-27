import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:unionportal/repository/send_complaint_repository.dart';

part 'send_complaint_event.dart';
part 'send_complaint_state.dart';

class SendComplaintBloc extends Bloc<SendComplaintEvent, SendComplaintState> {
  final SendComplaintRepository repository;

  SendComplaintBloc(this.repository) : super(SendComplaintInitial());

  TextEditingController userNameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController messageController = new TextEditingController();

  String _nameError = "";
  String _mobileError = "";
  String _messageError = "";

  var imagePath;
  String base64Image;
  String imageExtension;

  String get nameError => _nameError;

  String get mobileError => _mobileError;

  String get messageError => _messageError;

  @override
  Stream<SendComplaintState> mapEventToState(
    SendComplaintEvent event,
  ) async* {
    if (event is SendButtonEvent) {
      chickReportInputValidation(event.context);
      yield UserInput();
    }
  }

  chickReportInputValidation(BuildContext context) {
    if (userNameController.value.text.trim().length <= 0) {
      _nameError = "برجاء ادخال اسم مناسب";
    } else {
      _nameError = "";
    }
    if (mobileController.value.text.trim().length != 8) {
      _mobileError = "برجاء ادخال رقم هاتف مناسب";
    } else {
      _mobileError = "";
    }
    if (messageController.value.text.trim().length <= 0) {
      _messageError = "برجاء ادخال رساله مناسبه";
    } else {
      _messageError = "";
    }
    if (userNameController.value.text.trim().length > 0 &&
        mobileController.value.text.trim().length == 8 &&
        messageController.value.text.trim().length > 0) {
      _nameError = "";
      _mobileError = "";
      _messageError = "";

      sendUserReportInfo(context);
    }
  }

  void sendUserReportInfo(BuildContext context) async {
    try {
      await repository.sendComplaint(
        userNameController.text,
        mobileController.text,
        messageController.text,
      );
      Flushbar(
        messageText: Text(
          "تمت العملية بنجاح",
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 3),
        // dismissDirection:,
      )..show(context);
      leaveState();
    } catch (e) {
      print(e);
      Flushbar(
        message: "حدث خطا...برجاء المحاوله لاحقا",
        messageText: Text(
          "حدث خطا...برجاء المحاوله لاحقا",
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 3),
      )..show(context);
    }
  }

  void leaveState() {
    _nameError = "";
    _mobileError = "";
    _messageError = "";
    userNameController.clear();
    mobileController.clear();
    messageController.clear();
    imagePath = "";
    imageExtension = "";
  }
}
