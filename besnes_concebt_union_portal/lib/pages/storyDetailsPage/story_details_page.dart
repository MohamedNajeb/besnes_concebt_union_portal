
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart' as intl;
import 'package:unionportal/models/models.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import 'story_details/story_details_bloc.dart';

class StoryDetailsPage extends StatelessWidget {
  final int storyId;

  StoryDetailsPage(this.storyId);

  final dateFormatter = intl.DateFormat('yyyy-MM-dd | hh:mm a');

  StoryDetailsModel detailsModel;

  @override
  Widget build(BuildContext context) {
    final StoryDetailsBloc detailsBloc =
        BlocProvider.of<StoryDetailsBloc>(context);
    detailsBloc.add(FetchStoryDetails("ar", storyId));
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppTheme.appBackgroundColor,
        appBar: AppBar(
          title: Text("التفاصيل"),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  if (detailsModel != null) {
                    detailsBloc.add(ShareStory(detailsModel));
                  }
                },
                child: Icon(
                  Icons.share,
                  size: 6 * SizeConfig.imageSizeMultiplier,
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: BlocBuilder<StoryDetailsBloc, StoryDetailsState>(
            cubit: detailsBloc,
            builder: (context, state) {
              if (state is DetailsLoading) {
                return showLoadingSpinKit();
              } else if (state is DetailsDataLoaded) {
                return detailsWidget(context, state.model);
              } else if (state is DetailsError) {
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

  Widget detailsWidget(BuildContext context, StoryDetailsModel _detailsModel) {
    this.detailsModel = _detailsModel;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: AspectRatio(
              aspectRatio: 9 / 6,
              child: Container(
                height: 25 * SizeConfig.heightMultiplier,
                width: 95 * SizeConfig.widthMultiplier,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://www.cooopnet.com/Content/Upload/Slider/${_detailsModel.results.pictureName}",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Text(
                _detailsModel.results.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 2.5 * SizeConfig.textMultiplier,
                    color: AppTheme.buttonsColor,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.bold),
                maxLines: 3,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: .5,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: Text(
                    dateFormatter
                        .format(
                            DateTime.parse(_detailsModel.results.publishDate))
                        .toString(),
                    style: TextStyle(
                        fontSize: 2 * SizeConfig.textMultiplier,
                        color: AppTheme.textOrangeColor,
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: AppTheme.appBackgroundColor,
            padding: EdgeInsets.all(20.0),
            child: HtmlWidget(
              _detailsModel.results.body,
              webView: true,
              webViewJs: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget showLoadingSpinKit() => SpinKitFoldingCube(
        color: AppTheme.buttonsGradientColor1,
        size: 10 * SizeConfig.imageSizeMultiplier,
      );
}
