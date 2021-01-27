import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:unionportal/pages/price_comparison/price_comparison_page.dart';
import 'package:unionportal/repository/barcode_details_repository.dart';
import 'package:unionportal/repository/price_comparison_repository.dart';
import 'package:unionportal/repository/product_details_repository.dart';
import 'package:unionportal/repository/search_word_repository.dart';
import 'package:unionportal/utils/utils.dart';
import 'package:unionportal/widgets/tooltip_shapeborder.dart';

import '../../AppTheme.dart';
import '../barcodeDetails/barcode_details_page.dart';
import '../barcodeDetails/scannerSearchBloc/search_scanner_bloc.dart';
import '../price_comparison/barcode_pages.dart';
import '../price_comparison/priceComparisonBloc/price_comparison_bloc.dart';
import '../price_comparison/productDetailsBloc/product_details_bloc.dart';
import '../price_comparison/product_details_page.dart';
import '../price_comparison/widget/search_screen.dart';
import 'searchWordBloc/search_word_bloc.dart';

class ScreenScannerPage extends StatefulWidget {
  final BarcodeStare barcodeStare;

  ScreenScannerPage(this.barcodeStare);

  @override
  _ScreenScannerPageState createState() => _ScreenScannerPageState();
}

class _ScreenScannerPageState extends State<ScreenScannerPage> {
  String qrCodeResult = "";
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              headerWidget(context),
              bodyWidget(),
            ],
          ),
        ),
      ),
    );
  }

  /// Body Widget
  Widget bodyWidget() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () async {
              scanBarcodeNormal(context);
            },
            child: SvgPicture.asset(
              "assets/icons/barcode.svg",
              color: AppTheme.textOrangeColor,
              width: 200,
              height: 200,
            ),
          ),
          Text(
            Strings.BarCode,
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            qrCodeResult,
            style: TextStyle(fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// Header Widget
  /// [Search Field && back icon && Text description]
  Widget headerWidget(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        decoration: ShapeDecoration(
          color: AppTheme.buttonsColor,
          shape: TooltipShapeBorder(
            arrowHeight: 30,
            arrowWidth: 60,
            arrowArc: 0.1,
          ),
          shadows: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 5.0,
              offset: Offset(5, 5),
            )
          ],
        ),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      Strings.barcodeSearch,
                      textAlign: TextAlign.center,
                      style: Styling.txtTheme20n,
                    ),
                  ),
                  searchField(context),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        //widget.barcodeStare == BarcodeStare.PRICE_COMPARISON
                        Strings.barcodeDescription,
                        style: TextStyle(
                          color: AppTheme.appBackgroundColor,
                          fontFamily: "Cairo",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Search Field Widget..
  Widget searchField(BuildContext contex) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextField(
        textAlign: TextAlign.center,
        controller: titleController,
        textInputAction: TextInputAction.search,
        keyboardType: widget.barcodeStare == BarcodeStare.PRODUCT_DETAILS
            ? TextInputType.text
            : TextInputType.number,
        onSubmitted: (_) => submitData(),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 14.0),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: GestureDetector(
            onTap: () => submitData(),
            child: Icon(Icons.search, color: AppTheme.colorPrimary),
          ),
          suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: AppTheme.colorPrimary,
              ),
              onPressed: () {
                titleController.text = '';
              }),
          hintText: widget.barcodeStare == BarcodeStare.PRODUCT_DETAILS
              ? Strings.rechercherProduits
              : 'Barcode..',
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.secondary, width: 1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.secondary, width: 1),
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppTheme.secondary, width: 1.4),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }

  void submitData() {
    setState(() {
      qrCodeResult = titleController.text;
    });
    if (qrCodeResult.isNotEmpty) {
      if (widget.barcodeStare == BarcodeStare.PRICE_COMPARISON) {
        toPriceComparisonPage();
      } else if (widget.barcodeStare == BarcodeStare.PRODUCT_DETAILS) {
        navigateToSearchWord();
      } else if (widget.barcodeStare == BarcodeStare.MAIN_BARCODE) {
        navigateToBarcodeDetails();
      }
    } else {
      if (widget.barcodeStare == BarcodeStare.PRICE_COMPARISON ||
          widget.barcodeStare == BarcodeStare.MAIN_BARCODE) {
        _scaffoldKey.currentState.showSnackBar(
          showSnackBarM(Strings.emptyBarCode),
        );
      } else if (widget.barcodeStare == BarcodeStare.PRODUCT_DETAILS) {
        _scaffoldKey.currentState.showSnackBar(
          showSnackBarM(Strings.emptySearchField),
        );
      }
    }
  }

  Widget showSnackBarM(String text) => SnackBar(
        content: Text(
          text,
          textAlign: TextAlign.right,
          style: TextStyle(color: AppTheme.lightGrey, fontSize: 16),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: AppTheme.black,
      );

  Future<void> scanBarcodeNormal(BuildContext context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      if (barcodeScanRes != '' &&
          barcodeScanRes.isNotEmpty &&
          barcodeScanRes != '-1') {
        if (widget.barcodeStare == BarcodeStare.PRICE_COMPARISON) {
          toPriceComparisonPage();
        } else if (widget.barcodeStare == BarcodeStare.PRODUCT_DETAILS) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return BlocProvider<ProductDetailsBloc>(
                create: (context) =>
                    ProductDetailsBloc(ProductDetailsRepositoryImpl())
                      ..add(ProductDetails(itemBarcode: qrCodeResult)),
                child: ProductDetailsPage(itemBarcode: qrCodeResult),
              );
            }),
          );
        } else if (widget.barcodeStare == BarcodeStare.MAIN_BARCODE) {
          navigateToBarcodeDetails();
        }
      }
      //ProductDetailsPage
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      qrCodeResult = barcodeScanRes;
    });
  }

  void navigateToBarcodeDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider<SearchScannerBloc>(
          create: (context) => SearchScannerBloc(BarcodeDetailsRepositoryImpl())
            ..add(BarcodeDetails(qrCodeResult)),
          child: BarcodeDetailsPage(),
        );
      }),
    );
  }

  void navigateToSearchWord() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider<SearchWordBloc>(
          create: (context) => SearchWordBloc(SearchWordRepositoryImpl())
            ..add(SearchWord(qrCodeResult)),
          child: SearchScreen(searchWord: qrCodeResult),
        );
      }),
    );
  }

  void toPriceComparisonPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return BlocProvider<PriceComparisonBloc>(
          create: (context) =>
              PriceComparisonBloc(PriceComparisonRepositoryImpl())
                ..add(BarcodeComparisonDetails(qrCodeResult)),
          child: PriceComparisonPage(itemBarcode: qrCodeResult),
        );
      }),
    );
  }
}
