import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/setting/provider/ai_setting_provider.dart';

class TemperatureConfig extends StatelessWidget {
  const TemperatureConfig({super.key});

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
                  ShadTooltip(
                    builder: (context) {
                      return Text(
                        'You might want to use a lower temperature value for '
                        'tasks like fact-based QA to encourage more factual '
                        'and concise responses. For poem generation or other '
                        'creative tasks, it might be beneficial to increase '
                        'the temperature value.',
                        style: context.shadTextTheme.small,
                        textAlign: TextAlign.start,
                      );
                    },
                    child: Row(
                      children: [
                        Text('Temperature', style: context.shadTextTheme.large),
                        const SizedBox(width: 8),
                        const Icon(LucideIcons.info, size: 16),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Use a lower temperature for factual and concise responses '
                    'and a higher value for more diverse and creative '
                    'outputs.',
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
                  final asyncTemperature =
                      ref.watch(temperatureNotifierProvider);

                  return asyncTemperature.when(
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
            final asyncTemperature = ref.watch(temperatureNotifierProvider);

            return asyncTemperature.when(
              data: (val) {
                return ShadSlider(
                  initialValue: (val * 100).roundToDouble(),
                  divisions: 9,
                  min: 10,
                  max: 100,
                  trackHeight: 2,
                  onChanged: (value) {
                    ref
                        .read(temperatureNotifierProvider.notifier)
                        .saveTemperature(value / 100);
                  },
                );
              },
              error: (error, stackTrace) => const SizedBox.shrink(),
              loading: SizedBox.shrink,
            );
          },
        ),
      ],
    );
  }
}
