import 'package:flutter/material.dart';

import '../../core/route_names.dart';

class Feature {
  final String title, sub, route;
  final IconData icon;
  final Color color;
  const Feature(this.title, this.sub, this.route, this.icon, this.color);
}

const kFeatures = [
  Feature('AI Plant Doctor', 'Scan & diagnose\nplant problems', R.plantDoctor,
      Icons.biotech_rounded, Color(0xFF2E8B57)),
  Feature('Crop Recommendations', 'Find the best crops\nfor your land', R.crops,
      Icons.grass_rounded, Color(0xFF3C9A5F)),
  Feature('Weather Forecasts', 'Plan with confidence', R.weather,
      Icons.cloud_rounded, Color(0xFF4A90D9)),
  Feature('Government Schemes', 'Discover support\n& subsidies', R.schemes,
      Icons.account_balance_rounded, Color(0xFFE0A030)),
];
