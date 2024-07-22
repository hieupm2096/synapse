import 'package:flutter/cupertino.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';

class ContextWindowConfig extends StatefulWidget {
  const ContextWindowConfig({super.key});

  @override
  State<ContextWindowConfig> createState() => _ContextWindowConfigState();
}

class _ContextWindowConfigState extends State<ContextWindowConfig> {
  var _contextWindow = 2048;

  final _popoverController = ShadPopoverController();

  @override
  void dispose() {
    _popoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Context Window',
                style: context.shadTextTheme.large,
              ),
              const SizedBox(width: 12),
              Text(
                'Input token limit for generating responses',
                style: context.shadTextTheme.small.copyWith(
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        ShadPopover(
          controller: _popoverController,
          padding: EdgeInsets.zero,
          decoration: ShadDecoration(
            border: ShadBorder(radius: BorderRadius.circular(12)),
          ),
          popover: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _ContextWindowButton(
                  value: 4096,
                  selected: _contextWindow == 4096,
                  onTap: () {
                    _popoverController.toggle();

                    setState(() {
                      _contextWindow = 4096;
                    });
                  },
                ),
                _ContextWindowButton(
                  value: 2048,
                  selected: _contextWindow == 2048,
                  onTap: () {
                    _popoverController.toggle();

                    setState(() {
                      _contextWindow = 2048;
                    });
                  },
                ),
                _ContextWindowButton(
                  value: 1024,
                  selected: _contextWindow == 1024,
                  onTap: () {
                    _popoverController.toggle();

                    setState(() {
                      _contextWindow = 1024;
                    });
                  },
                ),
              ],
            );
          },
          child: CupertinoButton(
            onPressed: _popoverController.toggle,
            minSize: 0,
            padding: EdgeInsets.zero,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _contextWindow.toString(),
                  style: context.shadTextTheme.large,
                ),
                const SizedBox(width: 6),
                const Padding(
                  padding: EdgeInsets.only(top: 3.5),
                  child: Icon(LucideIcons.chevronRight, size: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ContextWindowButton extends StatelessWidget {
  const _ContextWindowButton({
    required this.value,
    required this.selected,
    required this.onTap,
  });

  final int value;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ShadButton.ghost(
      onPressed: onTap,
      width: 105,
      text: Expanded(
        child: Row(
          children: [
            Text(
              value.toString(),
              style: context.shadTextTheme.large,
              textAlign: TextAlign.start,
              overflow: TextOverflow.visible,
            ),
            if (selected) const SizedBox(width: 8),
            if (selected) const Icon(LucideIcons.check, size: 16),
          ],
        ),
      ),
    );
  }
}
