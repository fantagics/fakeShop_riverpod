import 'package:flutter/material.dart';

class NavigationService{
  static NavigationService shared = NavigationService();

  final GlobalKey<NavigatorState> navigationState = GlobalKey<NavigatorState>();
}