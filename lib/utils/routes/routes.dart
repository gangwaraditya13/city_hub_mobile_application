
import 'package:city_hub/utils/routes/routes_name.dart';
import 'package:city_hub/view/home_view.dart';
import 'package:city_hub/view/login_view.dart';
import 'package:city_hub/view/signup_view.dart';
import 'package:city_hub/view/signup_view3.dart';
import 'package:city_hub/view/signup_view_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => LoginView(),);
      case RoutesName.signup:
        return MaterialPageRoute(builder: (BuildContext context) => SignupView(),);
      case RoutesName.signup2:
        return MaterialPageRoute(builder: (BuildContext context) => SignupView2());
      case RoutesName.signup3:
        return MaterialPageRoute(builder: (BuildContext context) => SignupView3());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => HomeView());
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(body: Center(child: Text("No route define")));
          },
        );
    }
  }

}