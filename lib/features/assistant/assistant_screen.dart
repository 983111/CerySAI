import 'package:flutter/material.dart';

import '../../core/route_names.dart';
import '../../core/theme.dart';
import '../../core/widgets/widgets.dart';

class AssistantScreen extends StatelessWidget {
  final bool showBack;
  const AssistantScreen({super.key, this.showBack = true});

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
              const _BotBubble(
                child: Text(
                    "Hello! I'm your CerySAI assistant.\nAsk me anything about farming.",
                    style: TextStyle(fontSize: 11, height: 1.4)),
              ),
              const SizedBox(height: 18),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  constraints:
                      BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.72),
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
              const _BotBubble(child: _MarathiReply()),
            ]),
          ),
          const _InputBar(),
        ]),
      ),
    );
  }
}

class _BotBubble extends StatelessWidget {
  final Widget child;
  const _BotBubble({required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(color: C.dark, shape: BoxShape.circle),
        child: const Icon(Icons.eco_outlined, color: Colors.white, size: 18),
      ),
      const SizedBox(width: 8),
      Flexible(
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF1ED),
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        ),
      ),
    ]);
  }
}

class _MarathiReply extends StatelessWidget {
  const _MarathiReply();

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text("कांदा पिकावर 'पांढरी माशी' आणि\n'बुरशीजन्य' यांचा प्रादुर्भाव दिसत आहे.",
          style: TextStyle(fontSize: 11, height: 1.5)),
      const SizedBox(height: 10),
      const Text('उपाय:', style: TextStyle(fontSize: 11, height: 1.5)),
      const Text('1. नीम तेलाचा फवारणी करा (5%).', style: TextStyle(fontSize: 11, height: 1.6)),
      const Text('2. पिकावर नियमित निरीक्षण करा.', style: TextStyle(fontSize: 11, height: 1.6)),
      const Text('3. जैविक कीटकनाशकांचा वापर करा.',
          style: TextStyle(fontSize: 11, height: 1.6)),
      const SizedBox(height: 10),
      Row(children: [
        Container(
          width: 30,
          height: 30,
          decoration: const BoxDecoration(color: C.dark, shape: BoxShape.circle),
          child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Row(children: [
            Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(color: C.dark, shape: BoxShape.circle)),
            Expanded(child: Container(height: 2, color: Colors.black12)),
          ]),
        ),
        const SizedBox(width: 8),
        const Text('0:45', style: TextStyle(fontSize: 10, color: C.sub)),
      ]),
    ]);
  }
}

class _InputBar extends StatelessWidget {
  const _InputBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
