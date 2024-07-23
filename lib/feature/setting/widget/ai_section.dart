// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/setting/widget/context_window_config.dart';
import 'package:synapse/feature/setting/widget/freq_penalty_config.dart';
import 'package:synapse/feature/setting/widget/presence_penalty_config.dart';
import 'package:synapse/feature/setting/widget/temperature_config.dart';
import 'package:synapse/feature/setting/widget/top_p_config.dart';

class AiSection extends StatelessWidget {
  const AiSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
      decoration: BoxDecoration(
        color: context.shadColor.accent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          ContextWindowConfig(),
          Divider(height: 32),
          TemperatureConfig(),
          Divider(height: 32),
          TopPConfig(),
          Divider(height: 32),
          FreqPenaltyConfig(),
          Divider(height: 32),
          PresencePenaltyConfig(),
        ],
      ),
    );
  }
}
