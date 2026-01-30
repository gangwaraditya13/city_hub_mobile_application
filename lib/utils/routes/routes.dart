
import 'package:city_hub/utils/routes/routes_name.dart';
import 'package:city_hub/view/landing_view.dart';
import 'package:city_hub/view/login_view.dart';
import 'package:city_hub/view/signup_view.dart';
import 'package:city_hub/view/signup_view3.dart';
import 'package:city_hub/view/signup_view_2.dart';
import 'package:city_hub/view/splash_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.Splash:
        return MaterialPageRoute(builder: (BuildContext context) => SplashView(),);
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => LoginView(),);
      case RoutesName.signup:
        return MaterialPageRoute(builder: (BuildContext context) => SignupView(),);
      case RoutesName.signup2:
        return MaterialPageRoute(builder: (BuildContext context) => SignupView2());
      case RoutesName.signup3:
        return MaterialPageRoute(builder: (BuildContext context) => SignupView3());
      case RoutesName.landing:
        return MaterialPageRoute(builder: (BuildContext context) => LandingView());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(body: Center(child: Text("No route define")));
          },
        );
    }
  }

}