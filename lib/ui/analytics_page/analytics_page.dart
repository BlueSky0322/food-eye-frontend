import 'package:flutter/material.dart';
import 'package:food_eye_fyp/ui/analytics_page/analytics_page_state.dart';
import 'package:provider/provider.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<AnalyticsPageState>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              state.fetchWeatherForecast();
            },
            child: Text("Button"),
          ),
        ],
      ),
    );
  }
}
