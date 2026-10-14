import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const CerySaiApp());
}

/* ───────────────────────── THEME ───────────────────────── */

class C {
  static const green = Color(0xFF1B5E43);
  static const dark = Color(0xFF14483A);
  static const bg = Color(0xFFF8F8F4);
  static const text = Color(0xFF1C2A24);
  static const sub = Color(0xFF7A857F);
  static const line = Color(0xFFEAEAE4);
  static const mint = Color(0xFFE6F0E9);
  static const red = Color(0xFFD93A2B);
  static const alert = Color(0xFFFCEDE6);
}

BoxDecoration cardDeco([double r = 16, Color? color]) => BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: BorderRadius.circular(r),
      border: Border.all(color: C.line),
      boxShadow: const [
        BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 4))
      ],
    );

class R {
  static const splash = '/';
  static const home = '/home';
  static const plantDoctor = '/plant-doctor';
  static const crops = '/crops';
  static const assistant = '/assistant';
  static const weather = '/weather';
  static const schemes = '/schemes';
  static const language = '/language';
  static const listening = '/listening';
}

class CerySaiApp extends StatelessWidget {
  const CerySaiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CerySAI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: C.bg,
        colorScheme: ColorScheme.fromSeed(seedColor: C.green, primary: C.green),
        appBarTheme: const AppBarTheme(backgroundColor: C.bg, elevation: 0),
      ),
      initialRoute: R.splash,
      routes: {
        R.splash: (_) => const SplashScreen(),
        R.home: (_) => const MainShell(),
        R.plantDoctor: (_) => const PlantDoctorScreen(),
        R.crops: (_) => const CropRecommendationsScreen(),
        R.assistant: (_) => const AssistantScreen(),
        R.weather: (_) => const WeatherScreen(),
        R.schemes: (_) => const SchemesScreen(),
        R.language: (_) => const LanguageScreen(),
        R.listening: (_) => const ListeningScreen(),
      },
    );
  }
}

/* ───────────────────────── SHARED WIDGETS ───────────────────────── */

/// Loads assets/images/<name>. Falls back to a green gradient if missing,
/// so the app runs even before you add your photos.
class Pic extends StatelessWidget {
  final String name;
  final double? w, h;
  final BoxFit fit;
  const Pic(this.name, {super.key, this.w, this.h, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/$name',
      width: w,
      height: h,
      fit: fit,
      errorBuilder: (_, __, ___) => Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8DB35F), Color(0xFF2F5D34)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  final String title;
  final bool back;
  final Widget? trailing;
  const TopBar(this.title, {super.key, this.back = true, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: Row(children: [
        if (back)
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            onPressed: () => Navigator.maybePop(context),
          )
        else
          const SizedBox(width: 16),
        Text(title,
            style: const TextStyle(
                fontSize: 17, fontWeight: FontWeight.w700, color: C.text)),
        const Spacer(),
        if (trailing != null) trailing!,
      ]),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const PrimaryButton(this.label, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: C.dark,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        child: Text(label,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      ),
    );
  }
}

class LeafLogo extends StatelessWidget {
  final double size;
  final Color color;
  const LeafLogo({super.key, this.size = 56, this.color = C.green});
  @override
  Widget build(BuildContext context) =>
      Icon(Icons.eco_rounded, size: size, color: color);
}

class IconBadge extends StatelessWidget {
  final IconData icon;
  final Color bg, fg;
  final double size;
  const IconBadge(this.icon,
      {super.key, this.bg = C.mint, this.fg = C.green, this.size = 44});
  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Icon(icon, color: fg, size: size * 0.5),
      );
}

/* ───────────────────────── 1. SPLASH ───────────────────────── */

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBFAF4),
      body: Stack(children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: MediaQuery.of(context).size.height * 0.55,
          child: Stack(fit: StackFit.expand, children: [
            const Pic('field.jpg'),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFBFAF4), Color(0x00FBFAF4), Color(0x66000000)],
                  stops: [0, 0.35, 1],
                ),
              ),
            ),
          ]),
        ),
        SafeArea(
          child: Column(children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.16),
            const LeafLogo(size: 54),
            const Text('CerySAI',
                style: TextStyle(
                    fontSize: 38, fontWeight: FontWeight.w800, color: C.dark)),
            const SizedBox(height: 14),
            const Text('Smarter Farming\nfor a Brighter Tomorrow',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: C.text, height: 1.35)),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: PrimaryButton('Get Started',
                  onTap: () => Navigator.pushNamed(context, R.language)),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, R.home),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('Already have an account? Log In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w600)),
              ),
            ),
            const SizedBox(height: 28),
          ]),
        ),
      ]),
    );
  }
}

/* ───────────────────────── MAIN SHELL (bottom nav) ───────────────────────── */

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _i, children: const [
        HomeTab(),
        ExploreTab(),
        AssistantScreen(showBack: false),
        ProfileScreen(),
      ]),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: C.line)),
        ),
        child: BottomNavigationBar(
          currentIndex: _i,
          onTap: (v) => setState(() => _i = v),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: C.green,
          unselectedItemColor: C.sub,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search_rounded), label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline_rounded), label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

/* ───────────────────────── 2. HOME ───────────────────────── */

class _Feature {
  final String title, sub, route;
  final IconData icon;
  final Color color;
  const _Feature(this.title, this.sub, this.route, this.icon, this.color);
}

const _features = [
  _Feature('AI Plant Doctor', 'Scan & diagnose\nplant problems', R.plantDoctor,
      Icons.biotech_rounded, Color(0xFF2E8B57)),
  _Feature('Crop Recommendations', 'Find the best crops\nfor your land', R.crops,
      Icons.grass_rounded, Color(0xFF3C9A5F)),
  _Feature('Weather Forecasts', 'Plan with confidence', R.weather,
      Icons.cloud_rounded, Color(0xFF4A90D9)),
  _Feature('Government Schemes', 'Discover support\n& subsidies', R.schemes,
      Icons.account_balance_rounded, Color(0xFFE0A030)),
];

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Header with faded field image
      Stack(children: [
        Positioned.fill(
          top: 60,
          child: Stack(fit: StackFit.expand, children: [
            const Pic('field.jpg'),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [C.bg, Color(0x00F8F8F4)],
                  stops: [0.1, 0.9],
                ),
              ),
            ),
          ]),
        ),
        SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const Text('CerySAI',
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.w800, color: C.green)),
                const Spacer(),
                const Icon(Icons.notifications_none_rounded, color: C.text),
                const SizedBox(width: 12),
                const CircleAvatar(
                  radius: 15,
                  backgroundColor: C.mint,
                  child: Icon(Icons.person, size: 18, color: C.green),
                ),
              ]),
              const SizedBox(height: 18),
              const Text('Good Morning,\nFarmer!',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                      color: C.text)),
              const SizedBox(height: 8),
              const Text('Better decisions. Healthier crops.\nHigher yields.',
                  style: TextStyle(fontSize: 13, color: C.text, height: 1.35)),
              const SizedBox(height: 70),
            ]),
          ),
        ),
      ]),
      Expanded(
        child: Transform.translate(
          offset: const Offset(0, -28),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const ClampingScrollPhysics(),
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, R.assistant),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: cardDeco(),
                  child: Row(children: [
                    const IconBadge(Icons.eco_rounded, size: 46),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ask CerySAI',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w700)),
                            SizedBox(height: 2),
                            Text('Your AI farming assistant',
                                style: TextStyle(fontSize: 11, color: C.sub)),
                          ]),
                    ),
                    const Icon(Icons.chevron_right, color: C.sub),
                  ]),
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.25,
                children: [
                  for (final f in _features)
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, f.route),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: cardDeco(14),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconBadge(f.icon,
                                  bg: f.color.withOpacity(0.14),
                                  fg: f.color,
                                  size: 36),
                              const Spacer(),
                              Text(f.title,
                                  style: const TextStyle(
                                      fontSize: 12, fontWeight: FontWeight.w700)),
                              const SizedBox(height: 2),
                              Text(f.sub,
                                  style: const TextStyle(
                                      fontSize: 10, color: C.sub, height: 1.3)),
                            ]),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ]);
  }
}

/* ───────────────────────── EXPLORE TAB ───────────────────────── */

class ExploreTab extends StatelessWidget {
  const ExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(children: [
        const TopBar('Explore', back: false),
        Expanded(
          child: ListView(padding: const EdgeInsets.all(16), children: [
            for (final f in _features)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  onTap: () => Navigator.pushNamed(context, f.route),
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: C.line),
                  ),
                  leading: IconBadge(f.icon,
                      bg: f.color.withOpacity(0.14), fg: f.color, size: 40),
                  title: Text(f.title,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w700)),
                  subtitle: Text(f.sub.replaceAll('\n', ' '),
                      style: const TextStyle(fontSize: 11, color: C.sub)),
                  trailing: const Icon(Icons.chevron_right, color: C.sub),
                ),
              ),
          ]),
        ),
      ]),
    );
  }
}

/* ───────────────────────── 3. AI PLANT DOCTOR ───────────────────────── */

class _BracketPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final p = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round;
    const l = 30.0;
    final path = Path()
      ..moveTo(0, l)..lineTo(0, 0)..lineTo(l, 0)
      ..moveTo(s.width - l, 0)..lineTo(s.width, 0)..lineTo(s.width, l)
      ..moveTo(0, s.height - l)..lineTo(0, s.height)..lineTo(l, s.height)
      ..moveTo(s.width - l, s.height)..lineTo(s.width, s.height)..lineTo(s.width, s.height - l);
    canvas.drawPath(path, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class PlantDoctorScreen extends StatelessWidget {
  const PlantDoctorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const TopBar('AI Plant Doctor'),
          Expanded(
            child: ListView(padding: const EdgeInsets.symmetric(horizontal: 14), children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  height: 270,
                  child: Stack(fit: StackFit.expand, children: [
                    const Pic('leaf.jpg'),
                    Container(color: Colors.black.withOpacity(0.18)),
                    Positioned(
                      left: 26,
                      right: 26,
                      top: 22,
                      bottom: 56,
                      child: CustomPaint(painter: _BracketPainter()),
                    ),
                    Align(
                      alignment: const Alignment(0, 0.62),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: C.dark.withOpacity(0.9),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white54),
                        ),
                        child: const Icon(Icons.photo_camera_outlined,
                            color: Colors.white, size: 22),
                      ),
                    ),
                    const Align(
                      alignment: Alignment(0, 0.93),
                      child: Text('Tap to capture or upload image',
                          style: TextStyle(color: Colors.white, fontSize: 11)),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 18),
              Row(children: [
                const Text('Recent Detections',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                const Spacer(),
                const Text('View all',
                    style: TextStyle(fontSize: 11, color: C.green)),
              ]),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: cardDeco(14),
                child: Row(children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: const Pic('tomato.jpg', w: 60, h: 60),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Tomato Leaf Blight',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 2),
                            decoration: BoxDecoration(
                              color: C.alert,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(mainAxisSize: MainAxisSize.min, children: [
                              Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                      color: C.red, shape: BoxShape.circle)),
                              const SizedBox(width: 4),
                              const Text('Disease',
                                  style: TextStyle(fontSize: 10, color: C.red)),
                            ]),
                          ),
                          const SizedBox(height: 4),
                          const Text('Early stage',
                              style: TextStyle(fontSize: 11, color: C.sub)),
                        ]),
                  ),
                  const Icon(Icons.chevron_right, color: C.sub),
                ]),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: C.mint,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Row(children: [
                            Icon(Icons.medical_services_outlined,
                                size: 15, color: C.green),
                            SizedBox(width: 6),
                            Text('Recommended Treatment',
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700)),
                          ]),
                          SizedBox(height: 8),
                          _Bullet('Remove affected leaves'),
                          _Bullet('Use copper-based fungicide'),
                          _Bullet('Improve air circulation'),
                        ]),
                  ),
                  const Icon(Icons.chevron_right, color: C.sub),
                ]),
              ),
              const SizedBox(height: 16),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String t;
  const _Bullet(this.t);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 3),
        child: Row(children: [
          Container(
              width: 4,
              height: 4,
              decoration:
                  const BoxDecoration(color: C.text, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(t, style: const TextStyle(fontSize: 11, color: C.text)),
        ]),
      );
}

/* ───────────────────────── 4. CROP RECOMMENDATIONS ───────────────────────── */

class CropRecommendationsScreen extends StatelessWidget {
  const CropRecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const crops = [
      ['Soybean', 'Good for your soil type', 'soybean.jpg'],
      ['Pigeon Pea (Tur)', 'High demand in your region', 'pigeonpea.jpg'],
      ['Chickpea', 'Suitable for current weather', 'chickpea.jpg'],
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const TopBar('Crop Recommendations'),
          Expanded(
            child: ListView(padding: const EdgeInsets.symmetric(horizontal: 14), children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  height: 160,
                  child: Stack(fit: StackFit.expand, children: [
                    const Pic('crops_hero.jpg'),
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0x00000000), Color(0xAA000000)],
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 14,
                      bottom: 12,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Recommended Crops\nfor Your Land',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800,
                                    height: 1.2)),
                            SizedBox(height: 4),
                            Text('Based on soil, weather and location',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 10)),
                          ]),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: cardDeco(12),
                child: Row(children: [
                  const Icon(Icons.location_on, size: 18, color: C.green),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your Location',
                              style: TextStyle(fontSize: 9, color: C.sub)),
                          Text('Parbhani, Maharashtra',
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w600)),
                        ]),
                  ),
                  const Text('Change',
                      style: TextStyle(
                          fontSize: 11,
                          color: C.green,
                          fontWeight: FontWeight.w600)),
                ]),
              ),
              const SizedBox(height: 16),
              const Text('Top Recommendations',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              for (final c in crops)
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: cardDeco(12),
                  child: Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Pic(c[2], w: 48, h: 48),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(c[0],
                                style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 2),
                            Text(c[1],
                                style: const TextStyle(
                                    fontSize: 10, color: C.sub)),
                          ]),
                    ),
                    const Icon(Icons.chevron_right, color: C.sub),
                  ]),
                ),
            ]),
          ),
        ]),
      ),
    );
  }
}

/* ───────────────────────── 5. AI ASSISTANT ───────────────────────── */

class AssistantScreen extends StatelessWidget {
  final bool showBack;
  const AssistantScreen({super.key, this.showBack = true});

  Widget _botAvatar() => Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(color: C.dark, shape: BoxShape.circle),
        child: const Icon(Icons.eco_outlined, color: Colors.white, size: 18),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          TopBar(
            'AI Assistant',
            back: showBack,
            trailing: GestureDetector(
              onTap: () => Navigator.pushNamed(context, R.listening),
              child: const Icon(Icons.mic_none_rounded, color: C.text),
            ),
          ),
          Expanded(
            child: ListView(padding: const EdgeInsets.all(14), children: [
              // bot greeting
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _botAvatar(),
                const SizedBox(width: 8),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF1ED),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                        "Hello! I'm your CerySAI assistant.\nAsk me anything about farming.",
                        style: TextStyle(fontSize: 11, height: 1.4)),
                  ),
                ),
              ]),
              const SizedBox(height: 18),
              // user
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.72),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD5E7DA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                      'In Marathi: कांदा पिकावर कोणता रोग\nआढळतो आहे? त्यावर काय उपाय आहे?',
                      style: TextStyle(fontSize: 11, height: 1.4)),
                ),
              ),
              const SizedBox(height: 18),
              // bot reply
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                _botAvatar(),
                const SizedBox(width: 8),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF1ED),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                              "कांदा पिकावर 'पांढरी माशी' आणि\n'बुरशीजन्य' यांचा प्रादुर्भाव दिसत आहे.",
                              style: TextStyle(fontSize: 11, height: 1.5)),
                          const SizedBox(height: 10),
                          const Text('उपाय:',
                              style: TextStyle(fontSize: 11, height: 1.5)),
                          const Text('1. नीम तेलाचा फवारणी करा (5%).',
                              style: TextStyle(fontSize: 11, height: 1.6)),
                          const Text('2. पिकावर नियमित निरीक्षण करा.',
                              style: TextStyle(fontSize: 11, height: 1.6)),
                          const Text('3. जैविक कीटकनाशकांचा वापर करा.',
                              style: TextStyle(fontSize: 11, height: 1.6)),
                          const SizedBox(height: 10),
                          Row(children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                  color: C.dark, shape: BoxShape.circle),
                              child: const Icon(Icons.play_arrow_rounded,
                                  color: Colors.white, size: 20),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Row(children: [
                                Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                        color: C.dark, shape: BoxShape.circle)),
                                Expanded(
                                    child: Container(
                                        height: 2, color: Colors.black12)),
                              ]),
                            ),
                            const SizedBox(width: 8),
                            const Text('0:45',
                                style: TextStyle(fontSize: 10, color: C.sub)),
                          ]),
                        ]),
                  ),
                ),
              ]),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 6, 14, 12),
            child: Container(
              height: 46,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: C.line),
              ),
              child: Row(children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(fontSize: 11, color: C.sub),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, R.listening),
                  child: const Icon(Icons.mic_none_rounded, color: C.text),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

/* ───────────────────────── 6. WEATHER ───────────────────────── */

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const days = [
      ['Today', Icons.wb_cloudy_rounded, '28°', '22°', Color(0xFFF2B53D)],
      ['Thu', Icons.wb_cloudy_rounded, '30°', '23°', Color(0xFFF2B53D)],
      ['Fri', Icons.grain_rounded, '31°', '24°', Color(0xFF7D95B5)],
      ['Sat', Icons.grain_rounded, '29°', '22°', Color(0xFF7D95B5)],
    ];
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
                    SizedBox(
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
                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(children: const [
                            Icon(Icons.wb_cloudy_rounded,
                                size: 52, color: Color(0xFFF2B53D)),
                            SizedBox(width: 12),
                            Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('28°C',
                                      style: TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.w800)),
                                  Text('Partly Cloudy',
                                      style: TextStyle(fontSize: 12)),
                                  Text('H: 32°  L: 22°',
                                      style: TextStyle(fontSize: 10, color: C.sub)),
                                ]),
                          ]),
                        ),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          for (final d in days)
                            Column(children: [
                              Text(d[0] as String,
                                  style: const TextStyle(
                                      fontSize: 10, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 6),
                              Icon(d[1] as IconData,
                                  size: 20, color: d[4] as Color),
                              const SizedBox(height: 6),
                              Text(d[2] as String,
                                  style: const TextStyle(
                                      fontSize: 10, fontWeight: FontWeight.w700)),
                              Text(d[3] as String,
                                  style: const TextStyle(
                                      fontSize: 10, color: C.sub)),
                            ]),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: C.alert,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(children: [
                  const Icon(Icons.warning_amber_rounded, color: C.red, size: 26),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Rainfall Alert',
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: C.red)),
                          SizedBox(height: 2),
                          Text(
                              'Heavy rain expected on 16 Oct.\nConsider delaying fertilizer application.',
                              style: TextStyle(fontSize: 10, height: 1.4)),
                        ]),
                  ),
                  const Icon(Icons.chevron_right, color: C.sub),
                ]),
              ),
              const SizedBox(height: 18),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Padding(
                  padding: EdgeInsets.only(top: 2, left: 6),
                  child: Icon(Icons.lightbulb, size: 14, color: Color(0xFFE0A030)),
                ),
                SizedBox(width: 8),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Farming Advice',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
                  SizedBox(height: 6),
                  Text('Ideal weather for sowing\nsoybean this week.',
                      style: TextStyle(fontSize: 11, color: C.sub, height: 1.4)),
                ]),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }
}

/* ───────────────────────── 7. GOVERNMENT SCHEMES ───────────────────────── */

class SchemesScreen extends StatefulWidget {
  const SchemesScreen({super.key});
  @override
  State<SchemesScreen> createState() => _SchemesScreenState();
}

class _SchemesScreenState extends State<SchemesScreen> {
  int _chip = 0;
  final _chips = const ['All', 'Crop Support', 'Loan & Credit', 'Insurance'];
  final _items = const [
    ['Pradhan Mantri Kisan Samman Nidhi\n(PM-KISAN)',
      'Income support of ₹6,000 per year\nfor eligible farmers.', Icons.agriculture_rounded],
    ['PM Fasal Bima Yojana',
      'Crop insurance for farmers against\nnatural calamities.', Icons.eco_rounded],
    ['Soil Health Card Scheme',
      'Free soil testing and nutrient\nrecommendations.', Icons.science_rounded],
    ['Kisan Credit Card (KCC)',
      'Easy access to credit for farming needs.', Icons.shield_rounded],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const TopBar('Government Schemes'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: C.line),
              ),
              child: Row(children: const [
                Icon(Icons.search, size: 20, color: C.sub),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search schemes...',
                      hintStyle: TextStyle(fontSize: 11, color: C.sub),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 32,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              itemCount: _chips.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (_, i) => GestureDetector(
                onTap: () => setState(() => _chip = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: _chip == i ? C.dark : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: _chip == i ? C.dark : C.line),
                  ),
                  child: Text(_chips[i],
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: _chip == i ? Colors.white : C.sub)),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              itemCount: _items.length,
              itemBuilder: (_, i) {
                final it = _items[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: cardDeco(12),
                  child: Row(children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: C.mint,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(it[2] as IconData, color: C.green, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(it[0] as String,
                                style: const TextStyle(
                                    fontSize: 11, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 4),
                            Text(it[1] as String,
                                style: const TextStyle(
                                    fontSize: 10, color: C.sub, height: 1.35)),
                          ]),
                    ),
                    const Icon(Icons.chevron_right, color: C.sub),
                  ]),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}

/* ───────────────────────── 8. SELECT LANGUAGE ───────────────────────── */

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  int _sel = 0;
  final _langs = const ['English', 'हिंदी', 'मराठी', 'ગુજરાતી', 'தமிழ்', 'తెలుగు', 'ಕನ್ನಡ'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const TopBar('Select Language'),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                  'Choose your preferred language\nfor voice and text.',
                  style: TextStyle(fontSize: 12, color: C.text, height: 1.4)),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 14),
              decoration: cardDeco(12),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                physics: const ClampingScrollPhysics(),
                itemCount: _langs.length,
                separatorBuilder: (_, __) =>
                    const Divider(height: 1, color: C.line),
                itemBuilder: (_, i) => InkWell(
                  onTap: () => setState(() => _sel = i),
                  child: Container(
                    color: _sel == i ? C.bg : Colors.transparent,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
                    child: Row(children: [
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: _sel == i ? C.dark : Colors.black26,
                              width: _sel == i ? 5 : 1.4),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Text(_langs[i],
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: PrimaryButton('Continue',
                onTap: () => Navigator.pushNamedAndRemoveUntil(
                    context, R.home, (r) => false)),
          ),
        ]),
      ),
    );
  }
}

/* ───────────────────────── 9. LISTENING ───────────────────────── */

class ListeningScreen extends StatelessWidget {
  const ListeningScreen({super.key});

  Widget _wave(List<double> hs) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final h in hs)
            Container(
              width: 2.5,
              height: h,
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              decoration: BoxDecoration(
                color: const Color(0xFF3FA37A),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: C.dark,
      body: SafeArea(
        child: Column(children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          const SizedBox(height: 50),
          const LeafLogo(size: 26, color: Colors.white),
          const Text('CerySAI',
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 50),
          const Text('Listening...',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          const Spacer(),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _wave(const [18, 30, 44, 26, 16]),
            const SizedBox(width: 12),
            Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.05),
                border: Border.all(color: Colors.white12),
              ),
              child: Center(
                child: Container(
                  width: 104,
                  height: 104,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: C.dark,
                    border: Border.all(color: Colors.white70, width: 1.5),
                  ),
                  child: const Icon(Icons.mic_none_rounded,
                      color: Colors.white, size: 44),
                ),
              ),
            ),
            const SizedBox(width: 12),
            _wave(const [16, 26, 44, 30, 18]),
          ]),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Text('Tap to stop',
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
          const Spacer(),
        ]),
      ),
    );
  }
}

/* ───────────────────────── 10. PROFILE ───────────────────────── */

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget row(IconData i, String t, VoidCallback onTap) => Column(children: [
          ListTile(
            onTap: onTap,
            dense: true,
            leading: Icon(i, size: 20, color: C.text),
            title: Text(t, style: const TextStyle(fontSize: 12)),
            trailing: const Icon(Icons.chevron_right, size: 20, color: C.sub),
          ),
          const Divider(height: 1, color: C.line),
        ]);

    return SafeArea(
      child: Column(children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 16, 0),
            child: Icon(Icons.settings_outlined, color: C.text.withOpacity(0.8)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          child: Row(children: const [
            CircleAvatar(
              radius: 24,
              backgroundColor: C.mint,
              child: Icon(Icons.person, color: C.green, size: 28),
            ),
            SizedBox(width: 14),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Vishwajeet Adkine',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700)),
              SizedBox(height: 2),
              Text('vishwajeet@example.com',
                  style: TextStyle(fontSize: 11, color: C.sub)),
            ]),
          ]),
        ),
        const SizedBox(height: 10),
        const Divider(height: 1, color: C.line),
        row(Icons.agriculture_outlined, 'My Farm Details', () {}),
        row(Icons.language_rounded, 'Language',
            () => Navigator.pushNamed(context, R.language)),
        row(Icons.notifications_none_rounded, 'Notifications', () {}),
        row(Icons.help_outline_rounded, 'Help & Support', () {}),
        row(Icons.info_outline_rounded, 'About CerySAI', () {}),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(18),
          child: SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context, R.splash, (r) => false),
              icon: const Icon(Icons.logout_rounded, size: 18, color: C.red),
              label: const Text('Log Out',
                  style: TextStyle(color: C.red, fontSize: 12)),
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: C.line),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
