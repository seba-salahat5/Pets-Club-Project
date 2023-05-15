import 'package:flutter/material.dart';
import 'package:marahsebaproject/core/route/app_route_name.dart';
import 'package:marahsebaproject/veterinarydoctorbooking/home/presentation/home_screen.dart';

class AppRoute {
  static Route<dynamic>? generate(RouteSettings settings) {
    switch (settings.name) {
      case AppRouteName.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case AppRouteName.movieDetail:


  
    }
    return null;
  }
}
