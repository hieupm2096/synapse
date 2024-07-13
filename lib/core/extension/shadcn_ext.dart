import 'dart:ui';

import 'package:shadcn_ui/shadcn_ui.dart';

extension ShadExt on ShadColorScheme {
  Color get success => const Color(0xff23c55f);
  Color get error => const Color(0xffe11d48);
  Color get warning => const Color(0xfffacc16);
  Color get download => const Color(0xff2463eb);
}
