import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/setting/provider/ai_setting_provider.dart';

class TopPConfig extends StatefulWidget {
  const TopPConfig({super.key});

  @override
  State<TopPConfig> createState() => _TopPConfigState();
}

class _TopPConfigState extends State<TopPConfig> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Top P', style: context.shadTextTheme.large),
                  const SizedBox(width: 12),
                  Text(
                    'Keep this value low for exact and factual answers, '
                    'and increase it for more diverse responses.',
                    style: context.shadTextTheme.small.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 32,
              child: Consumer(
                builder: (context, ref, child) {
                  final asyncTopP = ref.watch(topPNotifierProvider);

                  return asyncTopP.when(
                    data: (data) {
                      return Text(
                        data.toStringAsFixed(1),
                        style: context.shadTextTheme.large,
                      );
                    },
                    error: (error, stackTrace) => const SizedBox.shrink(),
                    loading: SizedBox.shrink,
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Consumer(
          builder: (context, ref, child) {
            final asyncTopP = ref.watch(topPNotifierProvider);

            return asyncTopP.when(
              data: (val) {
                return ShadSlider(
                  initialValue: (val * 100).roundToDouble(),
                  divisions: 9,
                  min: 10,
                  max: 100,
                  trackHeight: 2,
                  onChanged: (value) {
                    ref
                        .read(topPNotifierProvider.notifier)
                        .saveTopP(value / 100);
                  },
                );
              },
              error: (error, stackTrace) => const SizedBox.shrink(),
              loading: () => const SizedBox.shrink(),
            );
          },
        ),
      ],
    );
  }
}
