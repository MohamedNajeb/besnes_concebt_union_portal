import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unionportal/models/models.dart';
import 'package:unionportal/pages/membersPage/membersBloc/members_bloc.dart';
import 'package:unionportal/pages/price_comparison/barcode_pages.dart';
import 'package:unionportal/pages/socialNewsPage/socialNewsBloc/social_news_bloc.dart';
import 'package:unionportal/repository/members_repository.dart';
import 'package:unionportal/repository/social_news_repository.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import '../membersPage/members_page.dart';
import '../screenScannerPage/screen_scanner_page.dart';
import '../socialNewsPage/social_news_page.dart';

class NavigationDrawerPageTap extends StatelessWidget {
  final SectionsModel sections;

  NavigationDrawerPageTap(this.sections);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: <Widget>[
          headerWidget(),
          sectionsWidget(),
        ],
      ),
    );
  }

  Widget headerWidget() {
    return Container(
      color: AppTheme.buttonsColor,
      child: DrawerHeader(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ImageIcon(
              AssetImage("assets/images/navheaderuser.png"),
              color: Colors.white,
              size: 10 * SizeConfig.imageSizeMultiplier,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: AutoSizeText(
                "تسجيل الدخول",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget sectionsWidget() {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
            right: 1.5 * SizeConfig.heightMultiplier,
            left: 1.5 * SizeConfig.heightMultiplier,
          ),
          child: Divider(
            color: AppTheme.gg,
            height: 1.0,
          ),
        );
      },
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: sections.results.length + 3,
      itemBuilder: (BuildContext context, int index) {
        if (index <= sections.results.length - 1) {
          return baseNewsItems(context, index);
        } else if (index == sections.results.length) {
          return addNewItem(
            context,
            text: 'مجلس الادارة',
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return BlocProvider<MembersBloc>(
                    create: (context) => MembersBloc(MembersRepositoryImpl())
                      ..add(FetchMembersData()),
                    child: MembersPage(),
                  );
                }),
              );
            },
          );
        } else if (index == sections.results.length + 1) {
          return addNewItem(
            context,
            text: 'مقارنة الاسعار',
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return ScreenScannerPage(BarcodeStare.PRICE_COMPARISON);
                }),
              );
            },
          );
        } else {
          return addNewItem(
            context,
            text: 'أسعار الاتحاد',
            onClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return ScreenScannerPage(BarcodeStare.PRODUCT_DETAILS);
                }),
              );
            },
          );
        }
      },
    );
  }

  Widget baseNewsItems(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(
          right: 2.0 * SizeConfig.heightMultiplier,
          left: 2.0 * SizeConfig.heightMultiplier,
          top: 1 * SizeConfig.heightMultiplier,
          bottom: 1 * SizeConfig.heightMultiplier),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return BlocProvider<SocialNewsBloc>(
                create: (context) => SocialNewsBloc(SocialNewsRepositoryImpl()),
                child: SocialNewsPage(sections.results[index].newSectionId,
                    sections.results[index].newSectionName),
              );
            }),
          );
        },
        child: Row(
          children: <Widget>[
            ImageIcon(
              AssetImage("assets/images/navbaricon.png"),
              color: AppTheme.textOrangeColor,
              size: 6 * SizeConfig.imageSizeMultiplier,
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.0, left: 8.0),
              child: Text(
                sections.results[index].newSectionName,
                style: TextStyle(
                  fontSize: 2.0 * SizeConfig.textMultiplier,
                  fontFamily: "Cairo",
                  color: AppTheme.titleTextColor,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget addNewItem(BuildContext context, {String text, Function onClick}) {
    return Padding(
      padding: EdgeInsets.only(
          right: 2.0 * SizeConfig.heightMultiplier,
          left: 2.0 * SizeConfig.heightMultiplier,
          top: 1 * SizeConfig.heightMultiplier,
          bottom: 1 * SizeConfig.heightMultiplier),
      child: InkWell(
        onTap: () {
          onClick();
        },
        child: Row(
          children: <Widget>[
            ImageIcon(
              AssetImage("assets/images/navbaricon.png"),
              color: AppTheme.textOrangeColor,
              size: 6 * SizeConfig.imageSizeMultiplier,
            ),
            Padding(
              padding: EdgeInsets.only(right: 8.0, left: 8.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 2.0 * SizeConfig.textMultiplier,
                  fontFamily: "Cairo",
                  color: AppTheme.titleTextColor,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
