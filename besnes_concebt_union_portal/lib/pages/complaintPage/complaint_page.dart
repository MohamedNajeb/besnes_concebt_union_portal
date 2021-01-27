import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unionportal/utils/Strings.dart';
import 'package:unionportal/utils/Styling.dart';
import 'package:unionportal/widgets/text_field_widget.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import 'send_ComplaintBloc/send_complaint_bloc.dart';

class ComplaintPage extends StatelessWidget {
  SendComplaintBloc sendComplaintBloc;

  @override
  Widget build(BuildContext context) {
    sendComplaintBloc = BlocProvider.of<SendComplaintBloc>(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () {
          sendComplaintBloc.close();
          Navigator.pop(context);
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text(Strings.complaintsAndSuggestions),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 5 * SizeConfig.imageSizeMultiplier),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 20 * SizeConfig.imageSizeMultiplier),
                    BlocBuilder<SendComplaintBloc, SendComplaintState>(
                      builder: (context, state) {
                        if (state is SendComplaintInitial) {
                          return textFieldWidget();
                        } else if (state is UserInput) {
                          return textFieldWidget();
                        } else {
                          return Container();
                        }
                      },
                    ),
                    SizedBox(height: 10),
                    sendButtonWidget(context),
                    SizedBox(height: 20),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldWidget() {
    return Column(
      children: <Widget>[
        TextFieldWidget(
          controller: sendComplaintBloc.userNameController,
          hintText: Strings.name,
          icon: Icons.person,
          keyboardType: TextInputType.emailAddress,
          errorText: sendComplaintBloc.nameError,
        ),
        SizedBox(height: 10),
        TextFieldWidget(
          controller: sendComplaintBloc.mobileController,
          hintText: Strings.mobilePhone,
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
          errorText: sendComplaintBloc.mobileError,
        ),
        SizedBox(height: 10),
        TextFieldWidget(
          controller: sendComplaintBloc.messageController,
          hintText: Strings.suggestionHere,
          maxLines: 5,
          errorText: sendComplaintBloc.messageError,
        ),
      ],
    );
  }

  Widget sendButtonWidget(BuildContext context) {
    return InkWell(
      onTap: () {
        sendComplaintBloc.add(SendButtonEvent(context));
      },
      child: Center(
        child: Container(
          width: 80 * SizeConfig.widthMultiplier,
          height: 6 * SizeConfig.heightMultiplier,
          decoration: BoxDecoration(
            color: AppTheme.buttonsColor,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 5.0,
                offset: Offset(5, 5),
              )
            ],
          ),
          child: Center(
            child: Text(
              Strings.send,
              style: Styling.txtThemeWhiteSizeW600,
            ),
          ),
        ),
      ),
    );
  }
}
