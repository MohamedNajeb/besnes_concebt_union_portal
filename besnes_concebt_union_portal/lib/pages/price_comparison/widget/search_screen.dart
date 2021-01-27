import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unionportal/models/search_word_model.dart';
import 'package:unionportal/pages/screenScannerPage/searchWordBloc/search_word_bloc.dart';
import 'package:unionportal/repository/product_details_repository.dart';

import '../../../AppTheme.dart';
import '../../../SizeConfig.dart';
import '../productDetailsBloc/product_details_bloc.dart';
import '../product_details_page.dart';

class SearchScreen extends StatelessWidget {
  final String searchWord;

  SearchScreen({this.searchWord});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'المتجات',
            style: TextStyle(
              fontFamily: "Cairo",
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            bodyWidget(context),
          ],
        ),
      ),
    );
  }

  Widget bodyWidget(BuildContext context) =>
      BlocBuilder<SearchWordBloc, SearchWordState>(
        builder: (context, state) {
          if (state is SearchWordLoading) {
            return showLoadingSpinKit();
          } else if (state is SearchWordLoaded) {
            if (state.model == null) {
              return hasErrorWidget(context);
            } else {
              return Expanded(
                child: setUbPriceInquiryListViewWidget(state.model),
              );
            }
          } else if (state is SearchWordError) {
            return Text(state.error);
          } else {
            return showLoadingSpinKit();
          }
        },
      );

  /// SetUb Price Inquiry List View Widget..
  Widget setUbPriceInquiryListViewWidget(List<SearchWordModel> list) =>
      ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return _buildDetailsItem(context, list[index]);
        },
        itemCount: list.length,
      );

  Widget _buildDetailsItem(BuildContext context, SearchWordModel item) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return BlocProvider<ProductDetailsBloc>(
                create: (context) =>
                    ProductDetailsBloc(ProductDetailsRepositoryImpl())
                      ..add(ProductDetails(itemBarcode: item.barcode)),
                child: ProductDetailsPage(itemBarcode: item.barcode),
              );
            }),
          );
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: AppTheme.itemColor,
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
                        item.itemARDescription,
                        style: TextStyle(
                            fontSize: 18.0,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.bold,
                            color: AppTheme.titleTextColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        item.barcode,
                        style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: "Cairo",
                            fontWeight: FontWeight.w600,
                            color: AppTheme.subTitleTextColor),
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
                  '${item.barcodePrice.toStringAsFixed(3)}',
                  style: TextStyle(
                    color: AppTheme.buttonsGradientColor1,
                    fontSize: 16.0,
                    fontFamily: "Cairo",
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      );

  /// hasError Widget..
  Widget hasErrorWidget(BuildContext context) => Center(
        child: Text(
          "الباركود غير مسجل",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontFamily: "Cairo",
              fontWeight: FontWeight.bold), //snapshot.error.toString(),
          textAlign: TextAlign.center,
          textScaleFactor: 1.3,
          maxLines: 10,
        ),
      );

  Widget showLoadingSpinKit() => SpinKitFoldingCube(
        color: AppTheme.buttonsGradientColor1,
        size: 10 * SizeConfig.imageSizeMultiplier,
      );
}
