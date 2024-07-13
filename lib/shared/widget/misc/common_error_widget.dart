import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/gen/assets.gen.dart';

class CommonErrorWidget extends StatelessWidget {
  const CommonErrorWidget({
    super.key,
    this.onRetry,
  });

  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 64),
          Assets.image.error.svg(height: 110),
          const SizedBox(height: 24),
          Text(
            'Oh no!',
            style: context.shadTextTheme.large.copyWith(
              color: context.shadColor.mutedForeground,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Something went wrong, please try again.',
            style: context.shadTextTheme.muted,
          ),
          const SizedBox(height: 16),
          ShadButton.outline(
            onPressed: onRetry,
            icon: const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(LucideIcons.refreshCw, size: 16),
            ),
            text: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
