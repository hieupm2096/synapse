import 'package:flutter/cupertino.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/chat/widget/chat_bubble.dart';
import 'package:url_launcher/url_launcher_string.dart';

class IntroBubbleChat extends StatelessWidget {
  const IntroBubbleChat({
    super.key,
    this.onDownloadTap,
    this.onSelectTap,
  });

  final VoidCallback? onDownloadTap;
  final VoidCallback? onSelectTap;

  @override
  Widget build(BuildContext context) {
    return ChatBubble.left(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'To start chatting, you need to',
            style: context.shadTextTheme.list,
          ),
          const SizedBox(height: 16),
          ShadButton(
            onPressed: onDownloadTap,
            size: ShadButtonSize.lg,
            text: Text(
              'Download model',
              style: context.shadTextTheme.large.copyWith(
                color: context.shadColor.primaryForeground,
              ),
            ),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {
              launchUrlString(
                'https://huggingface.co/microsoft/Phi-3-mini-4k-instruct',
              );
            },
            child: Text(
              'microsoft/Phi-3-mini-4k-instruct',
              style: context.shadTextTheme.list.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '''The model takes about 2.2GB in space and it works great on phone with 4GB of RAM or more.''',
            style: context.shadTextTheme.list,
          ),
          Text(
            '''You can also try other models by saving them to your phone and then''',
            style: context.shadTextTheme.list,
          ),
          const SizedBox(height: 16),

          // PICK LLM BUTTON
          ShadButton(
            onPressed: onSelectTap,
            size: ShadButtonSize.lg,
            text: Text(
              'Select it here',
              style: context.shadTextTheme.large.copyWith(
                color: context.shadColor.primaryForeground,
              ),
            ),
          ),

          const SizedBox(height: 16),
          Text(
            '''noticing that some models might not work great on mobile device.''',
            style: context.shadTextTheme.list,
          ),
          const SizedBox(height: 32),
          Text(
            '*Microsoft and Phi 3 are trademarks of '
            'Microsoft Corporation',
            style: context.shadTextTheme.list.copyWith(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
