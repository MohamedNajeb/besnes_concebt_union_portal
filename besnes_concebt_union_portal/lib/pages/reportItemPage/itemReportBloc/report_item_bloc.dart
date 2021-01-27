import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:unionportal/repository/report_item_repository.dart';

part 'report_item_event.dart';

part 'report_item_state.dart';

class ReportItemBloc extends Bloc<ReportItemEvent, ReportItemState> {
  TextEditingController userNameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController messageController = new TextEditingController();

  String _nameError = "";
  String _mobileError = "";
  String _messageError = "";

  File _imageFile;
  var imagePath;
  String base64Image;
  String imageExtension;

  final ReportItemRepository repository;

  ReportItemBloc(this.repository) : super(ReportItemInitial());

  File get imageFile => _imageFile;

  String get nameError => _nameError;

  String get mobileError => _mobileError;

  String get messageError => _messageError;

  @override
  Stream<ReportItemState> mapEventToState(
    ReportItemEvent event,
  ) async* {
    if (event is PickImageFromCamera) {
      await getImageFromCamera();
      yield ImagePicked();
    } else if (event is PickImageFromGallery) {
      await getImageFromGallery();
      yield ImagePicked();
    } else if (event is SendButtonEvent) {
      chickReportInputValidation(event.context);
      yield ImagePicked();
    }
  }

  chickReportInputValidation(BuildContext context) {
    if (userNameController.value.text.trim().length <= 0) {
      _nameError = "برجاء ادخال اسم مناسب";
    } else {
      _nameError = "";
    }
    if (_imageFile == null) {
      Flushbar(
        messageText: Text(
          "برجاء ارفاق صورة للمنتج",
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.right,
          style: TextStyle(color: Colors.white),
        ),
        duration: Duration(seconds: 3),
        // dismissDirection:,
      )..show(context);
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
        messageController.value.text.trim().length > 0 &&
        _imageFile != null) {
      _nameError = "";
      _mobileError = "";
      _messageError = "";

      sendUserReportInfo(context);
    }
  }

  void sendUserReportInfo(BuildContext context) async {
    try {
      await repository.sendReportInfo(
        userNameController.text,
        mobileController.text,
        messageController.text,
        base64Image,
        imageExtension,
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
    _imageFile = null;
    imagePath = "";
    imageExtension = "";
  }

  Future getImageFromGallery() async {
    var image = await ImagePicker().getImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500.0,
        maxWidth: 500.0);

    _imageFile = File(image.path);
    imagePath = _imageFile.path;
    imageExtension = imagePath.split('.').last;
    List<int> imageBytes = _imageFile.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
  }

  Future getImageFromCamera() async {
    final image = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 500.0,
        maxWidth: 500.0);

    _imageFile = File(image.path);
    imagePath = _imageFile.path;
    imageExtension = imagePath.split('.').last;
    List<int> imageBytes = _imageFile.readAsBytesSync();

    base64Image = base64Encode(imageBytes);
  }
}
