// ignore: unused_import
import 'package:storyadminpanel/main.dart';
import 'package:storyadminpanel/ui/login/create_admin.dart';
import 'package:storyadminpanel/ui/splash/splash_screen.dart';

import '../ui/home/home_page.dart';
import '../ui/login/login_page.dart';

var appRoutes = {

  KeyUtil.homePage: (context) => HomePage(),
  KeyUtil.loginPage: (context) => LoginPage(),
  KeyUtil.splashPage: (context) => SplashPage(),
  KeyUtil.adminPage: (context) => CreateAdminPage(),


};

class KeyUtil {

  static const String homePage = '/HomePage';
  static const String loginPage = '/LoginPage';
  static const String splashPage = '/SplashPage';
  static const String adminPage = '/AdminPage';




}
