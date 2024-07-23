import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/setting/provider/ai_setting_provider.dart';

class PresencePenaltyConfig extends StatelessWidget {
  const PresencePenaltyConfig({super.key});

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
                        'Think of this as a “variety encourager.” It nudges '
                        'the chef to open different spice jars, not just '
                        'the ones right in front. Higher values mean '
                        'more variety.',
                        style: context.shadTextTheme.small,
                        textAlign: TextAlign.start,
                      );
                    },
                    child: Row(
                      children: [
                        Text(
                          'Presenceuency Penalty',
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
                  final val = ref.watch(presencePNotifierProvider).value ?? 0;

                  return Text(
                    val.toStringAsFixed(1),
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
            final asyncPresenceP = ref.watch(presencePNotifierProvider);

            return asyncPresenceP.when(
              data: (data) {
                return ShadSlider(
                  initialValue: (data * 100).roundToDouble(),
                  divisions: 11,
                  min: 0,
                  max: 110,
                  trackHeight: 2,
                  onChanged: (value) {
                    ref
                        .read(presencePNotifierProvider.notifier)
                        .savePresencePenalty(value / 100);
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
