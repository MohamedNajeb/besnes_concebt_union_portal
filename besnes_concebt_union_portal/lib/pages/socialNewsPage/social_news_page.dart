import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart' as intl;
import 'package:unionportal/models/models.dart';
import 'package:unionportal/widgets/news_list_view_item.dart';
import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import 'socialNewsBloc/social_news_bloc.dart';

class SocialNewsPage extends StatelessWidget {
  final int sectionId;
  final String sectionName;
  final dateFormatter = intl.DateFormat('yyyy-MM-dd | hh:mm a');

  SocialNewsPage(this.sectionId, this.sectionName);

  SocialNewsBloc socialNewsBloc;

  @override
  Widget build(BuildContext context) {
    socialNewsBloc = BlocProvider.of<SocialNewsBloc>(context);
    socialNewsBloc.add(FetchSocialNews("ar", sectionId));
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFEFF2FA),
        appBar: AppBar(
          title: Text(sectionName),
        ),
        body: Center(
          child: BlocBuilder<SocialNewsBloc, SocialNewsState>(
            cubit: socialNewsBloc,
            builder: (context, state) {
              if (state is SocialNewsLoading) {
                return showLoadingSpinKit();
              } else if (state is SocialNewsLoaded) {
                return socialNewsWidget(context, state.model);
              } else if (state is SocialNewsError) {
                return Text(state.errorMessage);
              } else {
                return showLoadingSpinKit();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget socialNewsWidget(BuildContext context, CategoryModel model) {
    return Container(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: model.results.length,
        itemBuilder: (BuildContext context, int index) {
          return NewsListViewItem(
            index: index,
            model: model,
            dateFormatter: dateFormatter,
          );
        },
      ),
    );
  }

  Widget showLoadingSpinKit() {
    return SpinKitFoldingCube(
      color: AppTheme.buttonsGradientColor1,
      size: 10 * SizeConfig.imageSizeMultiplier,
    );
  }

  //TODO:
  dispose() {
    socialNewsBloc.close();
  }
}
