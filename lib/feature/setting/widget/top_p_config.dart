import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';

class TopPConfig extends StatefulWidget {
  const TopPConfig({super.key});

  @override
  State<TopPConfig> createState() => _TopPConfigState();
}

class _TopPConfigState extends State<TopPConfig> {
  var _topP = 100.0;

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
              child: Text(
                (_topP / 100).toStringAsFixed(1),
                style: context.shadTextTheme.large,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ShadSlider(
          initialValue: _topP,
          divisions: 9,
          min: 10,
          max: 100,
          trackHeight: 2,
          onChanged: (value) {
            setState(() {
              _topP = value;
            });
          },
        ),
      ],
    );
  }
}
