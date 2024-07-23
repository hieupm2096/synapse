import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_setting_provider.g.dart';

@Riverpod(keepAlive: true)
class DarkMode extends _$DarkMode {
  @override
  FutureOr<bool> build() {
    
    return false;
  }
}

