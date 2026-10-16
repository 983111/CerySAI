import 'package:flutter/material.dart';

import 'core/route_names.dart';
import 'features/about/about_screen.dart';
import 'features/assistant/assistant_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/signup_screen.dart';
import 'features/crops/crop_recommendations_screen.dart';
import 'features/help/help_screen.dart';
import 'features/language/language_screen.dart';
import 'features/legal/privacy_policy_screen.dart';
import 'features/legal/terms_screen.dart';
import 'features/plant_doctor/plant_doctor_screen.dart';
import 'features/schemes/schemes_screen.dart';
import 'features/voice/listening_screen.dart';
import 'features/weather/weather_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  R.login: (_) => const LoginScreen(),
  R.signup: (_) => const SignupScreen(),
  R.plantDoctor: (_) => const PlantDoctorScreen(),
  R.crops: (_) => const CropRecommendationsScreen(),
  R.assistant: (_) => const AssistantScreen(),
  R.weather: (_) => const WeatherScreen(),
  R.schemes: (_) => const SchemesScreen(),
  R.language: (_) => const LanguageScreen(),
  R.listening: (_) => const ListeningScreen(),
  R.help: (_) => const HelpScreen(),
  R.about: (_) => const AboutScreen(),
  R.privacy: (_) => const PrivacyPolicyScreen(),
  R.terms: (_) => const TermsScreen(),
};
