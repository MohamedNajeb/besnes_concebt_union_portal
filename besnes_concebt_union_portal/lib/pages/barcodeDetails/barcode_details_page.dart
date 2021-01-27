import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:unionportal/models/models.dart';
import 'package:unionportal/utils/utils.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import 'scannerSearchBloc/search_scanner_bloc.dart';

class BarcodeDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xFFE3E6EB),
        appBar: AppBar(
          title: Text(Strings.searchResult),
        ),
        body: BlocBuilder<SearchScannerBloc, SearchScannerState>(
          builder: (context, state) {
            if (state is SearchScannerLoading) {
              return showLoadingSpinKit();
            } else if (state is SearchScannerLoaded) {
              return bodyWidget(state.modelList);
            } else if (state is SearchScannerError) {
              return Center(
                child: Text(
                  Strings.thereIsNoProductData,
                  style: Styling.txtThemeSize2buttonsColor
                ),
              );
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

  Widget bodyWidget(List<BarcodeModel> modelList) {
    return Container(
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.network(modelList[index].imageUrl),
                  Container(
                    //  width: ,
                    color: Color(0xFFE3E6EB),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Text(
                              modelList[0].itemArDescription,
                              overflow: TextOverflow.ellipsis,
                              style: Styling.txtThemeSize2Bold
                            ),
                          ),
                          Container(
                            color: AppTheme.whitGround,
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  Strings.price,
                                  style: Styling.txtThemeSize2BoldOrangeColor
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    "${modelList[0].barcodePrice.toStringAsFixed(3)}",
                                    style: Styling.txtThemeSize2BoldOrangeColor
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              color: AppTheme.whitGround,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    Strings.description,
                                    style: Styling.txtThemeSize2Bold
                                  ),
                                  HtmlWidget(
                                    modelList[0].unitArDescription,
                                    textStyle: Styling.txtThemeSize2Bold2,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              color: AppTheme.whitGround,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    Strings.notes,
                                    style: Styling.txtThemeSize2Bold,
                                  ),
                                  HtmlWidget(
                                    modelList[0].notes,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
    );
  }
}
