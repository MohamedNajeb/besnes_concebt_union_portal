import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:unionportal/pages/storyDetailsPage/story_details/story_details_bloc.dart';
import 'package:unionportal/repository/story_details_repository.dart';

import '../../AppTheme.dart';
import '../../SizeConfig.dart';
import '../storyDetailsPage/story_details_page.dart';
import '../taps/home_page_tap.dart';
import '../taps/navigation_drawer_page_tap.dart';
import '../taps/searchTap/searsh_page_tap.dart';
import 'homeBloc/home_bloc.dart';
import 'package:connectivity/connectivity.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  String _connectionStatus = 'Unknown';
  Connectivity _connectivity;
  StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult connectResult;

  // @override
  // void initState() {
  //   super.initState();
  //   initConnectivity();
  //   _connectivitySubscription =
  //       _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  // }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _connectivity = Connectivity();
    _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen((ConnectivityResult result){
            this.connectResult = result;
          });

    //firebase messaging
    _firebaseMessaging.subscribeToTopic("news");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        if (message.isNotEmpty) {
          var messageData;
          bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
          if (isIOS) {
            //ios
            messageData = message;
          } else {
            //android
            messageData = message['data'];
          }

//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => storyDetailsPage(int.parse(messageData['id']))));
          //
          // print(messageData['id']);
          // processClickOnNotification(messageData);
        }
      },
      onResume: (Map<String, dynamic> message) {
        if (message.isNotEmpty) {
          var messageData;
          bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
          if (isIOS) {
            //ios
            messageData = message;
          } else {
            //android
            messageData = message['data'];
          }
          print(messageData['id']);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return BlocProvider<StoryDetailsBloc>(
                create: (context) =>
                    StoryDetailsBloc(StoryDetailsRepositoryImpl()),
                child: StoryDetailsPage(int.parse(messageData['id'])),
              );
            }),
          );
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) =>
//                      StoryDetailsPage(int.parse(messageData['id']))));
//          //  launch("https://s.alwakeelnews.com/${int.parse(messageData['id'])}");
        }
      },
      onLaunch: (Map<String, dynamic> message) {
        if (message.isNotEmpty) {
          var messageData;
          bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
          if (isIOS) {
            //ios
            messageData = message;
          } else {
            //android
            messageData = message['data'];
          }
          print(messageData['id']);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return BlocProvider<StoryDetailsBloc>(
                create: (context) =>
                    StoryDetailsBloc(StoryDetailsRepositoryImpl()),
                child: StoryDetailsPage(int.parse(messageData['id'])),
              );
            }),
          );
        }
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.getToken().then((token) {
      //  print(token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 3,
        initialIndex: 1,
        child: Scaffold(
          backgroundColor: AppTheme.appBackgroundColor,
          bottomNavigationBar: bottomNavigationBarWidget(context),
          body: Center(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeLoading) {
                  return showLoadingSpinKit();
                } else if (state is HomeDataLoaded) {
                  return bottomNavBarTapPages(state);
                } else if (state is HomeError) {
                  if(connectResult == ConnectivityResult.mobile || connectResult == ConnectivityResult.wifi){
                    return Text(state.errorMessage);
                  }else {
                    return Container(child: Center(child: Text('لا يوجد اتصال بالانترنت')),);
                  }
                } else {
                  if(connectResult == ConnectivityResult.mobile || connectResult == ConnectivityResult.wifi){
                    return showLoadingSpinKit();
                  }else {
                    return Container(child: Center(child: Text('لا يوجد اتصال بالانترنت')),);
                  }
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomNavBarTapPages(HomeDataLoaded state) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            NavigationDrawerPageTap(state.model.sections),
            HomePageTap(state.model.sliderNews),
            SearchPageTap(state.model.sections),
          ]),
    );
  }

  Widget bottomNavigationBarWidget(BuildContext context) {
    return SafeArea(
      bottom: true,
      right: true,
      left: true,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: EdgeInsets.fromLTRB(
              1 * SizeConfig.heightMultiplier,
              0.0,
              1 * SizeConfig.heightMultiplier,
              1.5 * SizeConfig.heightMultiplier),
          height: 7 * SizeConfig.heightMultiplier,
          width: MediaQuery.of(context).size.width,
          child: Material(
            color: AppTheme.buttonsColor,
            shadowColor: AppTheme.buttonsColor,
            elevation: 8.0,
            borderRadius: BorderRadius.all(const Radius.circular(20.0)),
            child: TabBar(
              isScrollable: false,
              labelColor: AppTheme.secondary,
              unselectedLabelColor: Colors.white,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                  color: AppTheme.appBackgroundColor,
                  width: 3.0,
                ),
                insets: EdgeInsets.fromLTRB(
                    30.0, 0.0, 30.0, 6 * SizeConfig.heightMultiplier),
              ),
              // labelStyle: ,
              tabs: <Widget>[
                bottomBarItemWidget(Icons.settings),
                bottomBarItemWidget(Icons.home),
                bottomBarItemWidget(Icons.search),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomBarItemWidget(IconData icon) {
    return Container(
      padding: EdgeInsets.only(top: 1 * SizeConfig.heightMultiplier),
      child: Center(
        child: Icon(
          icon,
          size: 7 * SizeConfig.imageSizeMultiplier,
        ),
      ),
    );
  }

  Widget showLoadingSpinKit() => SpinKitFoldingCube(
        color: AppTheme.buttonsGradientColor1,
        size: 10 * SizeConfig.imageSizeMultiplier,
      );
}
