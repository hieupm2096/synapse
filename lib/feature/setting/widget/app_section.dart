import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/setting/provider/app_setting_provider.dart';

class AppSection extends StatelessWidget {
  const AppSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
      decoration: BoxDecoration(
        color: context.shadColor.accent.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('Night mode', style: context.shadTextTheme.large),
              const Spacer(),
              Consumer(
                builder: (context, ref, child) {
                  final asyncDarkMode = ref.watch(darkModeProvider);

                  return asyncDarkMode.when(
                    data: (data) {
                      return ShadSwitch(
                        value: data,
                        onChanged: (v) {
                          ref
                              .read(darkModeProvider.notifier)
                              .saveDarkMode(isDarkMode: v);
                        },
                      );
                    },
                    error: (error, stackTrace) => const SizedBox.shrink(),
                    loading: SizedBox.shrink,
                  );
                },
              ),
            ],
          ),
          const Divider(height: 24),
          CupertinoButton(
            padding: EdgeInsets.zero,
            minSize: 0,
            onPressed: () {},
            child: Row(
              children: [
                Text('Language', style: context.shadTextTheme.large),
                const Spacer(),
                Row(
                  children: [
                    Text('English', style: context.shadTextTheme.p),
                    const SizedBox(width: 4),
                    const Icon(LucideIcons.chevronRight, size: 20),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
