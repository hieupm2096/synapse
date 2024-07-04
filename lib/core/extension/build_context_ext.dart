import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

extension BuildContextExt on BuildContext {
  ShadTextTheme get shadTextTheme => ShadTheme.of(this).textTheme;
  ShadColorScheme get shadColor => ShadTheme.of(this).colorScheme;
  ShadToasterState get shadToaster => ShadToaster.of(this);
}
