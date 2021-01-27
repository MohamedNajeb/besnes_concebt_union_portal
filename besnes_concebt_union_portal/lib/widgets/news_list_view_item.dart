import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' as intl;
import 'package:unionportal/pages/storyDetailsPage/story_details/story_details_bloc.dart';
import 'package:unionportal/pages/storyDetailsPage/story_details_page.dart';
import 'package:unionportal/repository/story_details_repository.dart';

import '../AppTheme.dart';
import '../SizeConfig.dart';

class NewsListViewItem extends StatelessWidget {
  final dynamic model;
  final int index;
  final intl.DateFormat dateFormatter;

  const NewsListViewItem({Key key, this.model, this.index, this.dateFormatter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: AppTheme.itemColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.0, color: Colors.grey[200]),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return BlocProvider<StoryDetailsBloc>(
                create: (context) =>
                    StoryDetailsBloc(StoryDetailsRepositoryImpl()),
                child: StoryDetailsPage(model.results[index].newId),
              );
            }),
          );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 4 / 3,
                child: Container(
                  decoration: BoxDecoration(
                    //color: Color(0xFFC3C0C0),
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://www.cooopnet.com/Content/Upload/Slider/${model.results[index].pictureName}"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Container(
                color: Color(0x00000029),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              dateFormatter
                                  .format(DateTime.parse(
                                      model.results[index].publishDate))
                                  .toString(),
                              style: TextStyle(
                                color: AppTheme.textOrangeColor,
                                fontSize: 1.7 * SizeConfig.textMultiplier,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Cairo",
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Container(
                              width: 3.0,
                              height: 30.0,
                              color: AppTheme.textOrangeColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          model.results[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 2 * SizeConfig.textMultiplier,
                              color: AppTheme.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Cairo"),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
