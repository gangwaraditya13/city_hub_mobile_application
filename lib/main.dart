import 'package:city_hub/model_view/home_view_model.dart';
import 'package:city_hub/model_view/image_view_model.dart';
import 'package:city_hub/model_view/login_view_model.dart';
import 'package:city_hub/model_view/signup_view_model.dart';
import 'package:city_hub/model_view/token_view_model.dart';
import 'package:city_hub/model_view/user_profile_view_model.dart';
import 'package:city_hub/model_view/user_view_model.dart';
import 'package:city_hub/resource/Theams/app_theme.dart';
import 'package:city_hub/utils/routes/routes.dart';
import 'package:city_hub/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LoginViewModel(),),
      ChangeNotifierProvider(create: (_) => SignupViewModel(),),
      ChangeNotifierProvider(create: (_) => TokenViewModel()),
      ChangeNotifierProvider(create: (_) => UserProfileViewModel()),
      ChangeNotifierProvider(create: (_) => HomeViewModel()),
      ChangeNotifierProvider(create: (_) => UserViewModel()),
      ChangeNotifierProvider(create: (_) => ImageViewModel()),
    ],child: MaterialApp(
      title: 'CityHub',
      theme: lightMode,
      darkTheme: darkMode,
      initialRoute: RoutesName.Splash,
      onGenerateRoute: Routes.generateRoute,
    ),
    );
  }
}
