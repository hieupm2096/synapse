import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';

class PresencePenaltyConfig extends StatefulWidget {
  const PresencePenaltyConfig({super.key});

  @override
  State<PresencePenaltyConfig> createState() => _PresencePenaltyConfigState();
}

class _PresencePenaltyConfigState extends State<PresencePenaltyConfig> {
  var _presencePenalty = 110.0;

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
              child: Text(
                (_presencePenalty / 100).toStringAsFixed(1),
                style: context.shadTextTheme.large,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ShadSlider(
          initialValue: _presencePenalty,
          divisions: 11,
          min: 0,
          max: 110,
          trackHeight: 2,
          onChanged: (value) {
            setState(() {
              _presencePenalty = value;
            });
          },
        ),
      ],
    );
  }
}
