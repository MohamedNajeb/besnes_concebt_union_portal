import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unionportal/models/models.dart';
import 'package:unionportal/utils/Styling.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import 'membersBloc/members_bloc.dart';

class MemberDetailsPage extends StatelessWidget {
  final String memberName;
  final int memberId;

  MemberDetailsPage(this.memberName, this.memberId);

  @override
  Widget build(BuildContext context) {
    final MembersBloc membersBloc = BlocProvider.of<MembersBloc>(context);
    membersBloc.add(FetchMemberDetails(memberId));
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFEFF2FA),
        appBar: AppBar(
          elevation: 0.0,
          title: AutoSizeText(memberName),
        ),
        body: BlocBuilder<MembersBloc, MembersState>(
          builder: (context, state) {
            if (state is SingleMemberLoading) {
              return showLoadingSpinKit();
            } else if (state is SingleMemberLoaded) {
              return Column(
                children: <Widget>[
                  headerWidget(context, state.singleMembersModel),
                ],
              );
            } else if (state is SingleMemberError) {
              return Text(state.errorMessage);
            } else {
              return showLoadingSpinKit();
            }
          },
        ),
      ),
    );
  }

  Widget headerWidget(
      BuildContext context, SingleWorkMemberModel singleMembersModel) {
    return Stack(
      children: <Widget>[
        buildHeaderBackground(),
        Positioned(
          child: buildHeaderContent(context, singleMembersModel),
          bottom: 0,
          right: 6 * SizeConfig.imageSizeMultiplier,
          left: 6 * SizeConfig.imageSizeMultiplier,
        ),
      ],
    );
  }

  Widget buildHeaderBackground() => Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            height: 50 * SizeConfig.imageSizeMultiplier,
            child: Container(
              color: AppTheme.buttonsColor,
            ),
          ),
          SizedBox(height: 8 * SizeConfig.imageSizeMultiplier),
        ],
      );

  Widget buildHeaderContent(
          BuildContext context, SingleWorkMemberModel memberModel) =>
      Row(
        children: <Widget>[
          buildProfile(context, "${memberModel.results.editorId}"),
          SizedBox(width: 24),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                memberModel.results.editorName,
                style: Styling.txtTheme14,
              ),
              AutoSizeText(
                memberModel.results.jobTitle,
                style: Styling.txtTheme16,
              ),
            ],
          ),
        ],
      );

  Widget buildProfile(BuildContext context, String memberImage) {
    final image = DecorationImage(
      fit: BoxFit.cover,
      image: NetworkImage(
        "https://www.cooopnet.com/Content/Upload/Editors/Large/$memberImage.jpg",
      ),
    );

    return Container(
      height: 25 * SizeConfig.heightMultiplier,
      width: 35 * SizeConfig.widthMultiplier,
      decoration: decoration(context, image: image),
    );
  }

  Decoration decoration(BuildContext context, {DecorationImage image}) =>
      BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(color: AppTheme.buttonsColor, spreadRadius: 4),
        ],
        image: image,
      );

  Widget showLoadingSpinKit() => SpinKitFoldingCube(
        color: AppTheme.buttonsGradientColor1,
        size: 10 * SizeConfig.imageSizeMultiplier,
      );
}
