import 'package:flutter/material.dart';

class HomePageState extends ChangeNotifier {
  final BuildContext context;
  DateTime nearestExpDate = DateTime.now();
  int expItemCount = 0;

  HomePageState(this.context);
}
