import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:intl/intl.dart' as intl;
import 'package:unionportal/models/models.dart';
import 'package:unionportal/widgets/news_list_view_item.dart';

import '../../../AppTheme.dart';
import '../../../SizeConfig.dart';
import 'searchBloc/search_bloc.dart';

class SearchPageTap extends StatefulWidget {
  final SectionsModel sections;

  SearchPageTap(this.sections);

  @override
  _SearchPageTapState createState() => _SearchPageTapState();
}

class _SearchPageTapState extends State<SearchPageTap> {
  final TextEditingController baseController = TextEditingController();
  String Error;
  final dateFormatter = intl.DateFormat('yyyy/MM/dd | hh:mm a');

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFEFF2FA),
        appBar: appBarWidget(),
        //drawer: advancedSearchDrawerWidget(sections),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: AppTheme.buttonsColor,
              child: Padding(
                padding: EdgeInsets.all(3 * SizeConfig.imageSizeMultiplier),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: searchTextFormFieldWidget(context)),
                    SizedBox(width: 10),
                    searchButtonWidget(context),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: BlocBuilder<SearchBloc, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return showLoadingSpinKit();
                    } else if (state is SearchResultLoaded) {
                      if (state.model.results.isEmpty) {
                        return Center(
                          child: Text(
                            'لا يوجد نتيجة لكلمة البحث \n  \"${baseController.text}\"',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: "Cairo",
                              color: AppTheme.black,
                            ),
                          ),
                        );
                      } else {
                        return searchResultWidget(state.model);
                      }
                    } else if (state is SearchResultError) {
                      return Text(state.errorMessage);
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget appBarWidget() {
    return AppBar(
      elevation: 0.0,
      title: Text("البحث"),
      centerTitle: true,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: ImageIcon(
              AssetImage("assets/images/search_drawer.png"),
              color: Colors.white,
              size: 6 * SizeConfig.imageSizeMultiplier,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
              //SearchState.initCondition();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    );
  }

  Widget searchTextFormFieldWidget(BuildContext context) {
    return TextFormField(
        cursorColor: AppTheme.gg,
        keyboardType: TextInputType.text,
        onFieldSubmitted: (value) {
          enterValue(context, value);
        },
        style: TextStyle(
          fontFamily: "Cairo",
          color: AppTheme.black,
        ),
        controller: baseController,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
          hintText: "البحث",
          hintStyle: TextStyle(
            color: AppTheme.subTitleTextColor,
          ),
          errorText: Error,
          filled: true,
          fillColor: AppTheme.colorPrimaryB,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: AppTheme.subTitleTextColor,
              width: 1.0,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: AppTheme.subTitleTextColor,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: AppTheme.subTitleTextColor,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: AppTheme.subTitleTextColor,
              width: 1.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(
              color: AppTheme.subTitleTextColor,
              width: 1.0,
            ),
          ),
        ));
  }

  Widget searchResultWidget(AdvancedSearchModel state) {
    return Container(
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: state.results.length,
          itemBuilder: (BuildContext context, int index) {
            return NewsListViewItem(
                index: index, model: state, dateFormatter: dateFormatter);
          }),
    );
  }

  int _sectionid = -1;
  String _Picked_from_senddate = "05-01-2010";
  String _Picked_to_senddate = "05-01-2040";

  void enterValue(BuildContext context, String value) {
    value = baseController.value.text.trim();
    if (value.length > 1) {
      Error = "";
      final searchBloc = BlocProvider.of<SearchBloc>(context);
      searchBloc.add(SimpleSearch("ar", value, _sectionid,
          _Picked_from_senddate, _Picked_to_senddate, 0));
    } else {
      Error = "برجاء اذخال كلمه بحث مناسبه";
    }
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Widget showLoadingSpinKit() {
    return SpinKitFoldingCube(
      color: AppTheme.buttonsGradientColor1,
      size: 10 * SizeConfig.imageSizeMultiplier,
    );
  }

  Widget searchButtonWidget(BuildContext context) {
    return ClipOval(
      child: Material(
        elevation: 5.0,
        color: AppTheme.appBackgroundColor, // button color
        child: InkWell(
          splashColor: Colors.white, // inkwell color
          child: SizedBox(
              width: 50,
              height: 50,
              child: Icon(
                Icons.search,
                color: AppTheme.buttonsColor,
              )),
          onTap: () {
            enterValue(context, baseController.text.trim());
          },
        ),
      ),
    );
//    return Container(
//      //  height: 10 * SizeConfig.heightMultiplier,
//      child: FlatButton(
//        color: Colors.blue,
//        onPressed: () {
//          enterValue(context, baseController.text.trim());
//        },
//        child: Text(
//          "بحث",
//          style: TextStyle(
//              color: Colors.white,
//              fontFamily: "Cairo",
//              fontSize: 2.5 * SizeConfig.textMultiplier),
//        ),
//      ),
//    );
  }
}
