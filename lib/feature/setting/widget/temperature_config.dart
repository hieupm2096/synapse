import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';

class TemperatureConfig extends StatefulWidget {
  const TemperatureConfig({super.key});

  @override
  State<TemperatureConfig> createState() => _TemperatureConfigState();
}

class _TemperatureConfigState extends State<TemperatureConfig> {
  var _temperature = 70.0;

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
              child: Text(
                (_temperature / 100).toStringAsFixed(1),
                style: context.shadTextTheme.large,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ShadSlider(
          initialValue: _temperature,
          divisions: 9,
          min: 10,
          max: 100,
          trackHeight: 2,
          onChanged: (value) {
            setState(() {
              _temperature = value;
            });
          },
        ),
      ],
    );
  }
}
