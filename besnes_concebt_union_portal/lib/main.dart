import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'AppTheme.dart';
import 'SizeConfig.dart';
import 'pages/homePage/homeBloc/home_bloc.dart';
import 'pages/homePage/home_page.dart';
import 'pages/taps/searchTap/searchBloc/search_bloc.dart';
import 'repository/home_slider_repository.dart';
import 'repository/search_repository.dart';



void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppTheme.buttonsColor));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(
        MyApp()); //device.DevicePreview(builder: (context) => MyApp())); //MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                return MediaQuery(
                  child: child,
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                );
              },
              title: "KUCCS",
              theme: AppTheme.lightTheme,
              home: MultiBlocProvider(
                providers: [
                  BlocProvider<HomeBloc>(create: (BuildContext context) {
                    return HomeBloc(HomeSliderRepositoryImpl())
                      ..add(FetchHomeData("ar"));
                  }),
                  BlocProvider<SearchBloc>(create: (BuildContext context) {
                    return SearchBloc(SearchRepositoryImpl());
                  }),
                ],
                child: HomePage(),
              ),
            );
          },
        );
      },
    );
  }
}
