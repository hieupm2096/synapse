import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/setting/widget/ai_section.dart';
import 'package:synapse/feature/setting/widget/app_section.dart';
import 'package:synapse/shared/shared.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  static String route = '/setting';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: const ShadBackButton(),
        title: Text(
          'Setting',
          style: context.shadTextTheme.h4,
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.1),
          child: Divider(height: 0.1),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App section
              Row(
                children: [
                  const Icon(LucideIcons.layoutGrid, size: 20),
                  const SizedBox(width: 6),
                  Text('App', style: context.shadTextTheme.large),
                ],
              ),
              const SizedBox(height: 10),
              const AppSection(),

              const SizedBox(height: 24),

              // AI section
              Row(
                children: [
                  const Icon(LucideIcons.bolt, size: 20),
                  const SizedBox(width: 6),
                  Text('AI', style: context.shadTextTheme.large),
                ],
              ),
              const SizedBox(height: 10),
              const AiSection(),
            ],
          ),
        ),
      ),
    );
  }
}
