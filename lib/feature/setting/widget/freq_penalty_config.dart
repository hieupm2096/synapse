import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';

class FreqPenaltyConfig extends StatefulWidget {
  const FreqPenaltyConfig({super.key});

  @override
  State<FreqPenaltyConfig> createState() => _FreqPenaltyConfigState();
}

class _FreqPenaltyConfigState extends State<FreqPenaltyConfig> {
  var _freqPenalty = 0.0;

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
              child: Text(
                (_freqPenalty / 100).toStringAsFixed(1),
                style: context.shadTextTheme.large,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ShadSlider(
          initialValue: _freqPenalty,
          divisions: 11,
          min: 0,
          max: 110,
          trackHeight: 2,
          onChanged: (value) {
            setState(() {
              _freqPenalty = value;
            });
          },
        ),
      ],
    );
  }
}
