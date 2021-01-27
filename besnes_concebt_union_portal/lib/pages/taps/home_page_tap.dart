import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:unionportal/models/models.dart';
import 'package:unionportal/pages/complaintPage/send_ComplaintBloc/send_complaint_bloc.dart';
import 'package:unionportal/pages/membersPage/membersBloc/members_bloc.dart';
import 'package:unionportal/pages/price_comparison/barcode_pages.dart';
import 'package:unionportal/pages/reportItemPage/itemReportBloc/report_item_bloc.dart';
import 'package:unionportal/pages/socialNewsPage/socialNewsBloc/social_news_bloc.dart';
import 'package:unionportal/pages/storyDetailsPage/story_details/story_details_bloc.dart';
import 'package:unionportal/repository/members_repository.dart';
import 'package:unionportal/repository/report_item_repository.dart';
import 'package:unionportal/repository/send_complaint_repository.dart';
import 'package:unionportal/repository/social_news_repository.dart';
import 'package:unionportal/repository/story_details_repository.dart';
import 'package:unionportal/widgets/home_section_item.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import '../complaintPage/complaint_page.dart';
import '../membersPage/members_page.dart';
import '../reportItemPage/report_item_page.dart';
import '../screenScannerPage/screen_scanner_page.dart';
import '../socialNewsPage/social_news_page.dart';
import '../storyDetailsPage/story_details_page.dart';

class HomePageTap extends StatelessWidget {
  final HomeSliderModel homeSliderList;

  HomePageTap(this.homeSliderList);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: AppBar(
          title: Text("الرئيسيه"),
          centerTitle: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            homeImageSlider(context, homeSliderList),
            homeSectionItems(context),
          ],
        ),
      ),
    );
  }

  Widget homeImageSlider(
          BuildContext context, HomeSliderModel homeSliderList) =>
      Container(
        color: AppTheme.appBackgroundColor, //Color(0xFFF8F8F8),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: ConstrainedBox(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Swiper(
                  autoplay: true,
                  autoplayDelay: 6000,
                  scrollDirection: Axis.horizontal,
                  outer: false,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return BlocProvider<StoryDetailsBloc>(
                              create: (context) => StoryDetailsBloc(
                                  StoryDetailsRepositoryImpl()),
                              child: StoryDetailsPage(
                                homeSliderList.results[index].newId,
                              ),
                            );
                          }),
                        );
                      },
                      child: Wrap(
                        runSpacing: 6.0,
                        children: [0].map((i) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  height: 30 * SizeConfig.heightMultiplier,
                                  width:
                                      MediaQuery.of(context).size.width * .95,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://www.cooopnet.com/Content/Upload/Slider/${homeSliderList.results[index].pictureName}",
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: .5 * SizeConfig.heightMultiplier,
                                    right: 1 * SizeConfig.heightMultiplier,
                                    left: 1 * SizeConfig.heightMultiplier),
                                child: Text(
                                  homeSliderList.results[index].title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: AppTheme.titleTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 2 * SizeConfig.textMultiplier,
                                    fontFamily: "Cairo",
                                  ),
                                  maxLines: 2,
                                ),
                              )
                            ],
                          );
                        }).toList(),
                      ),
                    );
                  },
                  pagination: SwiperPagination(
                      margin: EdgeInsets.all(5.0),
                      builder: DotSwiperPaginationBuilder(
                        activeColor: AppTheme.buttonsColor,
                        color: AppTheme.gg,
                      )),
                  itemCount: homeSliderList.results.length,
                ),
              ),
              constraints: BoxConstraints.loose(new Size(
                  MediaQuery.of(context).size.width,
                  43 * SizeConfig.heightMultiplier))),
        ),
      );

  navigateToSocialNewsPage(
      BuildContext context, int sectionId, String sectionName) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider<SocialNewsBloc>(
          create: (context) => SocialNewsBloc(SocialNewsRepositoryImpl()),
          child: SocialNewsPage(sectionId, sectionName),
        );
      }),
    );
  }

  Widget homeSectionItems(BuildContext context) => Container(
        //color: AppTheme.gg, //Color(0xFFEFF2FA),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HomeSectionItem(
                    itemImageURL: "assets/images/socialnews.png",
                    itemText: "أخبار إجتماعية",
                    onItemClicked: () {
                      navigateToSocialNewsPage(context, 2, "أخبار إجتماعية");
                    },
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 20.0),
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: 2.0,
                      child: VerticalDivider(color: AppTheme.gg)),
                  HomeSectionItem(
                    itemImageURL: "assets/images/jamianews.png",
                    itemText: "أخبار الإتحاد",
                    onItemClicked: () {
                      navigateToSocialNewsPage(context, 8, "أخبار الإتحاد");
                    },
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 20.0),
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: 2.0,
                      child: VerticalDivider(color: AppTheme.gg)),
                  HomeSectionItem(
                    itemImageURL: "assets/images/offers.png",
                    itemText: "عروض",
                    onItemClicked: () {
                      navigateToSocialNewsPage(context, 10, "عروض");
                    },
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                height: 2.0,
                width: MediaQuery.of(context).size.width,
                child: Divider(color: AppTheme.gg)),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HomeSectionItem(
                    itemImageURL: "assets/images/report_item.png",
                    itemText: "الإبلاغ عن سلعه",
                    onItemClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return BlocProvider<ReportItemBloc>(
                            create: (context) =>
                                ReportItemBloc(ReportItemRepositoryImpl()),
                            child: ReportItemPage("الإبلاغ عن سلعه"),
                          );
                        }),
                      );
                    },
                  ),
                  Container(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: 2.0,
                      child: VerticalDivider(color: AppTheme.gg)),
                  HomeSectionItem(
                    itemImageURL: "assets/images/barcode.png",
                    itemText: "قارىء الباركود",
                    onItemClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ScreenScannerPage(BarcodeStare.MAIN_BARCODE);
                        }),
                      );
                    },
                  ),
                  Container(
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: 2.0,
                      child: VerticalDivider(color: AppTheme.gg)),
                  HomeSectionItem(
                    itemImageURL: "assets/images/complain.png",
                    itemText: "شكاوى واقتراحات",
                    onItemClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return BlocProvider<SendComplaintBloc>(
                            create: (context) => SendComplaintBloc(
                                SendComplaintRepositoryImpl()),
                            child: ComplaintPage(),
                          );
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                height: 2.0,
                width: MediaQuery.of(context).size.width,
                child: Divider(color: AppTheme.gg)),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  HomeSectionItem(
                    itemImageURL: "assets/images/finreports.png",
                    itemText: "التقارير الماليه",
                    onItemClicked: () {},
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 20.0),
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: 2.0,
                      child: VerticalDivider(color: AppTheme.gg)),
                  HomeSectionItem(
                    itemImageURL: "assets/images/board.png",
                    itemText: "مجلس الإدارة",
                    onItemClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return BlocProvider<MembersBloc>(
                            create: (context) =>
                                MembersBloc(MembersRepositoryImpl())
                                  ..add(FetchMembersData()),
                            child: MembersPage(),
                          );
                        }),
                      );
                    },
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 20.0),
                      height: MediaQuery.of(context).size.width * 0.3,
                      width: 2.0,
                      child: VerticalDivider(color: AppTheme.gg)),
                  HomeSectionItem(
                    itemImageURL: "assets/images/barcode.png",
                    itemText: "بحث المتجات",
                    onItemClicked: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return ScreenScannerPage(
                              BarcodeStare.PRODUCT_DETAILS);
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
