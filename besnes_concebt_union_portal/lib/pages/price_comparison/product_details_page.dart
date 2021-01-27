import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unionportal/models/details.dart';
import 'package:unionportal/models/getItem_details_by_barcode_model.dart';
import 'package:unionportal/utils/utils.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import 'productDetailsBloc/product_details_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final String itemBarcode;

  ProductDetailsPage({this.itemBarcode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
        builder: (context, state) {
          if (state is ProductDetailsLoading) {
            return showLoadingSpinKit();
          } else if (state is ProductDetailsLoaded) {
            if (state.model == null) {
              return hasErrorWidget(context, Strings.thereIsNoProductData);
            } else {
              return bodyWidget(context, state.model);
            }
          } else if (state is ProductDetailsError) {
            return hasErrorWidget(context, state.error);
          } else {
            return showLoadingSpinKit();
          }
        },
      ),
    );
  }

  Widget showLoadingSpinKit() => SpinKitFoldingCube(
        color: AppTheme.buttonsGradientColor1,
        size: 10 * SizeConfig.imageSizeMultiplier,
      );

  Widget bodyWidget(BuildContext context, GetItemDetailsByBarcodeModel model) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: <Widget>[
          // header..
          headerWidget(context, model),

          // list..
          Expanded(
            child: setUbPriceInquiryListViewWidget(model.details),
          ),
        ],
      ),
    );
  }

  /// SetUb Price Inquiry List View Widget..
  Widget setUbPriceInquiryListViewWidget(List<Details> item) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return _buildDetailsItem(context, item[index]);
      },
      itemCount: item.length,
    );
  }

  /// Header Widget..
  Widget headerWidget(BuildContext context, GetItemDetailsByBarcodeModel item) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 150.0,
                  width: double.infinity,
                  color: AppTheme.buttonsColor,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 70.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    ),
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Material(
                          elevation: 10,
                          color: AppTheme.colorPrimary,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Stack(
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(height: 16),
                                    Text(
                                      item.itemARDescription,
                                      style: Styling.txtTheme18w900),
                                    SizedBox(height: 10),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          item.barcodePrice.toStringAsFixed(3),
                                          style: Styling.txtTheme16black,
                                        ),
                                        Text(
                                          ' kd ',
                                          style: Styling.txtTheme18blackbold,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                  ],
                                ),
                              ),
                              Positioned(
                                  bottom: 150,
                                  left: -40,
                                  child: Container(
                                    height: 140,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(70),
                                        color: Colors.yellowAccent[100]
                                            .withOpacity(0.1)),
                                  )),
                              Positioned(
                                  top: -120,
                                  left: 100,
                                  child: Container(
                                    height: 300,
                                    width: 300,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(150),
                                        color: Colors.yellowAccent[100]
                                            .withOpacity(0.1)),
                                  )),
                              Positioned(
                                  top: -50,
                                  left: 0,
                                  child: Container(
                                    height: 200,
                                    width: 200,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Colors.yellowAccent[100]
                                            .withOpacity(0.1)),
                                  )),
                              Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(75),
                                        color: Colors.yellowAccent[100]
                                            .withOpacity(0.1)),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 25.0),
                  child: Center(
                    child: Text(
                      'تفاصيل المنتج',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 20.0,
                        color: AppTheme.appBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsItem(BuildContext context, Details item) {
    return Container(
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
                    item.title,
                    style: Styling.txtTheme18bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    item.descriptions,
                    style: Styling.txtTheme12w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// hasError Widget..
  Widget hasErrorWidget(BuildContext context, String messag) {
    return Center(
      child: Text(
        messag, //snapshot.error.toString(),
        textAlign: TextAlign.center,
        textScaleFactor: 1.3,
        maxLines: 10,
        style: TextStyle(fontFamily: "Cairo"),
      ),
    );
  }
}
