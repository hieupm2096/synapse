import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/setting/provider/ai_setting_provider.dart';

class FreqPenaltyConfig extends StatelessWidget {
  const FreqPenaltyConfig({super.key});

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
                        'This is like a “repeat police” in the kitchen. '
                        'It stops the chef from using the same ingredient '
                        'too often. Higher values mean stricter policing.',
                        style: context.shadTextTheme.small,
                        textAlign: TextAlign.start,
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'Frequency Penalty',
                          style: context.shadTextTheme.large,
                        ),
                        const SizedBox(width: 8),
                        const Icon(LucideIcons.info, size: 16),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Higher values means fewer repeated words',
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
                  final val = ref.watch(frequencyPNotifierProvider).value;

                  return Text(
                    val == null ? '-' : val.toStringAsFixed(1),
                    style: context.shadTextTheme.large,
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Consumer(
          builder: (context, ref, child) {
            final asyncFreqP = ref.watch(frequencyPNotifierProvider);

            return asyncFreqP.when(
              data: (data) {
                return ShadSlider(
                  initialValue: (data * 100).roundToDouble(),
                  divisions: 11,
                  min: 0,
                  max: 110,
                  trackHeight: 2,
                  onChanged: (value) {
                    ref
                        .read(frequencyPNotifierProvider.notifier)
                        .saveFrequencyPenalty(value / 100);
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
