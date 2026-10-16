import 'package:flutter/material.dart';

import '../theme.dart';

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
