import 'package:flutter/material.dart';
import 'package:provider_test1/features/assignment/model/assignment_model.dart';
import 'package:provider_test1/features/assignment/view/add_assignment.dart';
import 'package:provider_test1/features/assignment/view/get_assignment.dart';
import 'package:provider_test1/features/home/view/bottom_navbar1.dart';
import 'package:provider_test1/features/home/view/home1.dart';
import 'package:provider_test1/features/login/view/login1.dart';
import 'package:provider_test1/features/login/view/register1.dart';
import 'package:provider_test1/utils/notifications_page.dart';
import 'package:provider_test1/utils/route_const.dart';

class RouteGenerator {
  static navigateToPage(
    BuildContext context,
    String route, {
    dynamic arguments,
  }) {
    Navigator.push(
      context,
      generateRoute(RouteSettings(name: route, arguments: arguments)),
    );
  }

  static navigateToPageWithoutStack(
    BuildContext context,
    String route, {
    dynamic arguments,
  }) {
    Navigator.pushAndRemoveUntil(
      context,
      generateRoute(RouteSettings(name: route, arguments: arguments)),
      (route) => false,
    );
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Login());
      case Routes.signupRoute:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => Register());
      // case Routes.addAssignment:
      //   return PageRouteBuilder(pageBuilder: (_, __, ___) => AddAssignment());
      case Routes.getAssignment:
        return PageRouteBuilder(pageBuilder: (_, __, ___) => GetAssignment());
      // case Routes.getStartedRoute:
      //   return PageRouteBuilder(
      //       pageBuilder: (_, __, ___) => const GetStarted());
      // case Routes.forgotPasswordRoute:
      //   return PageRouteBuilder(
      //       pageBuilder: (_, __, ___) => const ForgotPassword());
      // case Routes.enterOtpRoute:
      //   return PageRouteBuilder(pageBuilder: (_, __, ___) =>  EnterOtp(phoneEmailOtpDetails: settings.arguments as PhoneEmailOTPDetails,));
      // case Routes.resetPasswordRoute:
      //   return PageRouteBuilder(
      //       pageBuilder: (_, __, ___) =>  ResetPassword(email: settings.arguments as String,));
      case Routes.bottomNavbarRoute:
        return PageRouteBuilder(
          pageBuilder: (_, __, ___) => const BottomNavbar1(),
        );
      case Routes.homeRoute:
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (_, __, ___) => const Home1(),
        );
      case Routes.addAssignment:
        print(settings.arguments);
        return PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (_, __, ___) => AddAssignment(
            assignmentModel: settings.arguments!=null?settings.arguments as AssignmentModel:null,
          ),
        );
      // case Routes.carBookingRoute:
      //   return PageRouteBuilder(
      //       pageBuilder: (_, __, ___) => CarBookingPage(
      //             carDetail: settings.arguments as Car,
      //           ));
      // case Routes.addCarDetailsRoute:
      //   return PageRouteBuilder(
      //     pageBuilder: (_, __, ___) => AddCarForm(
      //         car: settings.arguments != null
      //             ? settings.arguments as Car
      //             : null),
      //     //  pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {  }
      //   );
      // case Routes.viewCarListRoute:
      //   return PageRouteBuilder(
      //       pageBuilder: (_, __, ___) => ViewCarListScreen(
      //           fromHomePage: settings.arguments as bool? ?? false));
      // case Routes.settingsRoute:
      //   return PageRouteBuilder(
      //       pageBuilder: (_, __, ___) => SettingsPage(
      //           users: settings.arguments != null
      //               ? settings.arguments as Users
      //               : null));

      case Routes.notificationRoute:
        return PageRouteBuilder(
            pageBuilder: (_, __, ___) => const NotificationsPage());
      default:
        return PageRouteBuilder(
          pageBuilder:
              (_, __, ___) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
