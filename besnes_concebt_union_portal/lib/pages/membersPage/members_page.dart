import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unionportal/models/models.dart';
import 'package:unionportal/repository/members_repository.dart';
import 'package:unionportal/utils/Strings.dart';
import 'package:unionportal/utils/Styling.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import 'member_details_page.dart';
import 'membersBloc/members_bloc.dart';

class MembersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFEFF2FA),
        appBar: AppBar(
          elevation: 0.0,
          title: AutoSizeText(Strings.boardDirectors),
        ),
        body: BlocBuilder<MembersBloc, MembersState>(
          builder: (context, state) {
            if (state is MembersLoading) {
              return showLoadingSpinKit();
            } else if (state is MembersLoaded) {
              return Column(
                children: <Widget>[
                  headerWidget(context, state.allMembersModel),
                  SizedBox(height: 10 * SizeConfig.imageSizeMultiplier),
                  Expanded(
                    child:
                        staggeredGridViewWidget(context, state.allMembersModel),
                  ),
                ],
              );
            } else if (state is MembersError) {
              return Text(state.errorMessage);
            } else {
              return showLoadingSpinKit();
            }
          },
        ),
      ),
    );
  }

  Widget showLoadingSpinKit() => SpinKitFoldingCube(
        color: AppTheme.buttonsGradientColor1,
        size: 10 * SizeConfig.imageSizeMultiplier,
      );

  Widget headerWidget(
      BuildContext context, AllWorkMembersModel allMembersModel) {
    return Stack(
      children: <Widget>[
        buildHeaderBackground(),
        Positioned(
          child: buildHeaderContent(context, allMembersModel),
          bottom: 0,
          right: 6 * SizeConfig.imageSizeMultiplier,
          left: 6 * SizeConfig.imageSizeMultiplier,
        ),
      ],
    );
  }

  Widget buildHeaderContent(
          BuildContext context, AllWorkMembersModel allMembersModel) =>
      Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return BlocProvider<MembersBloc>(
                    create: (context) => MembersBloc(MembersRepositoryImpl()),
                    child: MemberDetailsPage(
                      allMembersModel.results[0].editorName,
                      allMembersModel.results[0].editorId,
                    ),
                  );
                }),
              );
            },
            child: buildProfile(
                context, "${allMembersModel.results[0].editorId}", true),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AutoSizeText(
                allMembersModel.results[0].jobTitle,
                style: Styling.txtTheme16,
              ),
              AutoSizeText(
                allMembersModel.results[0].editorName,
                style: Styling.txtTheme16,
              ),
            ],
          ),
        ],
      );

  Widget buildProfile(
      BuildContext context, String allMembersModel, bool isPresident) {
    final image = DecorationImage(
      fit: BoxFit.cover,
      image: NetworkImage(
        "https://www.cooopnet.com/Content/Upload/Editors/Large/$allMembersModel.jpg",
      ),
    );

    return Container(
      height: isPresident
          ? 25 * SizeConfig.heightMultiplier
          : 35 * SizeConfig.heightMultiplier,
      width: isPresident
          ? 35 * SizeConfig.widthMultiplier
          : 45 * SizeConfig.widthMultiplier,
      decoration: decoration(context, isPresident, image: image),
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

  Decoration decoration(BuildContext context, bool isPresident,
          {DecorationImage image}) =>
      BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
              color: isPresident
                  ? AppTheme.buttonsColor
                  : Theme.of(context).scaffoldBackgroundColor,
              spreadRadius: isPresident ? 6 : 4)
        ],
        image: image,
      );

  Widget staggeredGridViewWidget(
          BuildContext context, AllWorkMembersModel allMembersModel) =>
      StaggeredGridView.countBuilder(
          primary: false,
          crossAxisCount: 2,
          itemCount: allMembersModel.results.length - 1,
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
          padding: EdgeInsets.only(top: 5 * SizeConfig.widthMultiplier),
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return BlocProvider<MembersBloc>(
                        create: (context) =>
                            MembersBloc(MembersRepositoryImpl()),
                        child: MemberDetailsPage(
                          allMembersModel.results[index + 1].editorName,
                          allMembersModel.results[index + 1].editorId,
                        ),
                      );
                    }),
                  );
                },
                child: Container(
                  margin:
                      EdgeInsets.only(bottom: 5 * SizeConfig.widthMultiplier),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      buildProfile(
                          context,
                          "${allMembersModel.results[index + 1].editorId}",
                          false),
                      Positioned(
                        bottom: 0.0,
                        child: Container(
                          width: 45 * SizeConfig.widthMultiplier,
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AutoSizeText(
                                allMembersModel.results[index + 1].editorName,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: Styling.txtTheme16,
                              ),
                              AutoSizeText(
                                allMembersModel.results[index + 1].jobTitle,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: Styling.txtTheme16,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ));
          });
}
