import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unionportal/models/models.dart';
import 'package:unionportal/pages/reportItemPage/itemReportBloc/report_item_bloc.dart';
import 'package:unionportal/repository/report_item_repository.dart';
import 'package:unionportal/utils/Strings.dart';
import 'package:unionportal/utils/Styling.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import '../reportItemPage/report_item_page.dart';
import 'priceComparisonBloc/price_comparison_bloc.dart';

class PriceComparisonPage extends StatelessWidget {
  final String itemBarcode;

  PriceComparisonPage({this.itemBarcode});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PriceComparisonBloc, PriceComparisonState>(
      builder: (context, state) {
        if (state is PriceComparisonLoading) {
          return showLoadingSpinKit();
        } else if (state is PriceComparisonLoaded) {
          if (state.model == null) {
            return errorWidget();
          } else {
            return comparisonResultWidget(context, state.model);
          }
        } else if (state is PriceComparisonError) {
          return errorWidget();
        } else {
          return showLoadingSpinKit();
        }
      },
    );
  }

  Widget showLoadingSpinKit() => Container(
        color: AppTheme.buttonsColor,
        child: SpinKitFoldingCube(
          color: AppTheme.buttonsGradientColor1,
          size: 10 * SizeConfig.imageSizeMultiplier,
        ),
      );

  Widget comparisonResultWidget(
          BuildContext context, List<GetByBarcodeModel> model) =>
      Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: AppTheme.buttonsColor,
          body: Column(
            children: <Widget>[
              // header..
              headerWidget(context, model[0]),
              // list..
              setUbComparisonListViewWidget(model),
            ],
          ),
        ),
      );

  /// Header Widget..
  Widget headerWidget(BuildContext context, GetByBarcodeModel item) {
    return Container(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.04,
          right: 20.0,
          left: 20.0),
      color: AppTheme.buttonsColor,
      height: MediaQuery.of(context).size.height * 0.250,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  Strings.BarCode,
                  style: Styling.txtTheme20,
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppTheme.liteGray,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    itemBarcode,
                    style: Styling.txtTheme,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  Strings.federationAssociations,
                  style: Styling.txtTheme20BackgroundColor,
                ),
                SizedBox(height: 10),
                Text(
                  '${item.price.toStringAsFixed(3)}',
                  style: Styling.txtTheme20GradientColor1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Comparison Item Widget..
  Widget _buildComparisonItem(BuildContext context, GetByBarcodeModel model,
      GetByBarcodeModel firstItem) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: model.price > firstItem.price
            ? AppTheme.colorI
            : AppTheme.itemColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(width: 1.0, color: Colors.grey[200]),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.0),
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    model.companyName,
                    style: Styling.txtTheme18bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    model.itemName,
                    style: Styling.txtTheme12w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20.0),
            alignment: Alignment.centerRight,
            child: Text(
              '${model.price.toStringAsFixed(3)}',
              style: Styling.txtTheme16w600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          model.price > firstItem.price
              ? Container(
                  margin: EdgeInsets.only(right: 20.0),
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return BlocProvider<ReportItemBloc>(
                            create: (context) =>
                                ReportItemBloc(ReportItemRepositoryImpl()),
                            child: ReportItemPage(Strings.reportingItems),
                          );
                        }),
                      );
                    },
                    child: Text(
                      Strings.reportingItem,
                      style: Styling.txtTheme12w600GradientColor2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  /// set Ub Comparison List View Widget ..
  Widget setUbComparisonListViewWidget(List<GetByBarcodeModel> item) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: AppTheme.backGround,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0),
            ),
            border: Border.all(width: 1.0, color: Colors.white),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              )
            ]),
        child: Container(
          margin: EdgeInsets.only(top: 40),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return index > 0
                  ? _buildComparisonItem(context, item[index], item[0])
                  : Container();
            },
            itemCount: item.length, //currentUser.orders.length,
          ),
        ),
      ),
    );
  }

  /// hasError Widget..
  Widget hasErrorWidget(BuildContext context) {
    return Center(
      child: Text(
        Strings.barcodeNotRegistered,
        style: Styling.txtTheme20bold, //snapshot.error.toString(),
        textAlign: TextAlign.center,
        textScaleFactor: 1.3,
        maxLines: 10,
      ),
    );
  }

  Widget errorWidget() => Scaffold(
        backgroundColor: AppTheme.buttonsColor,
        body: Container(
          child: Center(
            child: Text(
              Strings.thereIsNoProductData,
              style: Styling.errorTxtTheme,
            ),
          ),
        ),
      );
}
