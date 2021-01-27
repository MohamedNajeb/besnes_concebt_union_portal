import 'package:flutter/material.dart';
import 'package:unionportal/pages/price_comparison/price_comparison_page.dart';

class RouteGenerator {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      // case PriceComparisonPage.routeName:
      //   return MaterialPageRoute(builder: (_) => PriceComparisonPage());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
