import 'package:flutter/material.dart';

import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  static const _days = [
    ['Today', Icons.wb_cloudy_rounded, '28°', '22°', Color(0xFFF2B53D)],
    ['Thu', Icons.wb_cloudy_rounded, '30°', '23°', Color(0xFFF2B53D)],
    ['Fri', Icons.grain_rounded, '31°', '24°', Color(0xFF7D95B5)],
    ['Sat', Icons.grain_rounded, '29°', '22°', Color(0xFF7D95B5)],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const TopBar('Weather Forecasts'),
          Expanded(
            child: ListView(padding: const EdgeInsets.symmetric(horizontal: 14), children: [
              const Padding(
                padding: EdgeInsets.only(left: 4, bottom: 8),
                child: Row(children: [
                  Icon(Icons.location_on, size: 14, color: C.green),
                  SizedBox(width: 6),
                  Text('Parbhani, Maharashtra',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                ]),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  color: Colors.white,
                  child: Column(children: [
                    const _CurrentWeather(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [for (final d in _days) _DayColumn(d)],
                      ),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 14),
              const _RainAlert(),
              const SizedBox(height: 18),
              const _Advice(),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _CurrentWeather extends StatelessWidget {
  const _CurrentWeather();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: Stack(fit: StackFit.expand, children: [
        const Pic('weather.jpg'),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF4F7F0), Color(0x55F4F7F0)],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(14),
          child: Row(children: [
            Icon(Icons.wb_cloudy_rounded, size: 52, color: Color(0xFFF2B53D)),
            SizedBox(width: 12),
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('28°C', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
                  Text('Partly Cloudy', style: TextStyle(fontSize: 12)),
                  Text('H: 32°  L: 22°', style: TextStyle(fontSize: 10, color: C.sub)),
                ]),
          ]),
        ),
      ]),
    );
  }
}

class _DayColumn extends StatelessWidget {
  final List<Object> d;
  const _DayColumn(this.d);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(d[0] as String, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600)),
      const SizedBox(height: 6),
      Icon(d[1] as IconData, size: 20, color: d[4] as Color),
      const SizedBox(height: 6),
      Text(d[2] as String, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700)),
      Text(d[3] as String, style: const TextStyle(fontSize: 10, color: C.sub)),
    ]);
  }
}

class _RainAlert extends StatelessWidget {
  const _RainAlert();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: C.alert, borderRadius: BorderRadius.circular(12)),
      child: Row(children: const [
        Icon(Icons.warning_amber_rounded, color: C.red, size: 26),
        SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Rainfall Alert',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: C.red)),
            SizedBox(height: 2),
            Text('Heavy rain expected on 16 Oct.\nConsider delaying fertilizer application.',
                style: TextStyle(fontSize: 10, height: 1.4)),
          ]),
        ),
        Icon(Icons.chevron_right, color: C.sub),
      ]),
    );
  }
}

class _Advice extends StatelessWidget {
  const _Advice();

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
      Padding(
        padding: EdgeInsets.only(top: 2, left: 6),
        child: Icon(Icons.lightbulb, size: 14, color: Color(0xFFE0A030)),
      ),
      SizedBox(width: 8),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Farming Advice', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
        SizedBox(height: 6),
        Text('Ideal weather for sowing\nsoybean this week.',
            style: TextStyle(fontSize: 11, color: C.sub, height: 1.4)),
      ]),
    ]);
  }
}
