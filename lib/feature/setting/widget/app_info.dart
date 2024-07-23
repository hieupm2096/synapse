import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:synapse/core/core.dart';

class AppInfo extends StatelessWidget {
  AppInfo({super.key});

  final _future = PackageInfo.fromPlatform();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const SizedBox.shrink();
          }

          final packageInfo = snapshot.data!;

          final appName = packageInfo.appName;
          final version = packageInfo.version;
          final buildNumber = packageInfo.buildNumber;

          return Text(
            '$appName v$version build $buildNumber',
            style: context.shadTextTheme.muted,
          );
        },
      ),
    );
  }
}
