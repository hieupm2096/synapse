import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/app.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/chat/provider/create_prompt_provider.dart';
import 'package:synapse/feature/chat/provider/prompt_reply_provider.dart';
import 'package:synapse/feature/chat/widget/chat_generating.dart';
import 'package:synapse/feature/chat/widget/chat_input.dart';

class TypeAndSend extends ConsumerStatefulWidget {
  const TypeAndSend({
    super.key,
  });

  @override
  ConsumerState<TypeAndSend> createState() => _TypeAndSendState();
}

class _TypeAndSendState extends ConsumerState<TypeAndSend> {
  // bool _isTextEmpty = true;

  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncPromptStatus = ref.watch(promptReplyProvider).status;

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
      decoration: BoxDecoration(
        color: context.shadColor.background,
        border: Border(top: BorderSide(color: context.shadColor.border)),
      ),
      child: SafeArea(
        child: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.enter):
                asyncPromptStatus != PromptReplyStatus.inProgress
                    ? _onSend
                    : () {},
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: ChatInput(
                        enabled:
                            asyncPromptStatus != PromptReplyStatus.inProgress,
                        controller: _controller,
                      ),
                    ),
                  ),
                  ShadButton.ghost(
                    onPressed: asyncPromptStatus != PromptReplyStatus.inProgress
                        ? _onSend
                        : null,
                    icon: const Icon(LucideIcons.sendHorizontal, size: 22)
                        .animate(
                          target:
                              asyncPromptStatus != PromptReplyStatus.inProgress
                                  ? 0
                                  : 1,
                          autoPlay: false,
                        )
                        .swap(
                          duration: 500.ms,
                          builder: (context, child) => const ChatGenerating(),
                        ),
                    size: ShadButtonSize.lg,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                'The data could be inaccurate.',
                style: context.shadTextTheme.muted.copyWith(
                  fontSize: 11,
                  // fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void _onChange(String v) {
  //   setState(() {
  //     _isTextEmpty = v.isEmpty;
  //   });
  // }

  void _onSend() {
    logDebug('onSend');

    FocusScope.of(context).unfocus();

    final text = _controller.text.trim();

    _controller.clear();

    if (text.isEmpty) return;

    final currentLlmId = ref.read(currentLlmProvider).value?.id;
    final currentLlmPath = ref.read(currentLlmProvider).value?.path;

    if (currentLlmId == null || currentLlmPath == null) return;

    final currentConversationId =
        ref.read(currentConversationProvider(llmId: currentLlmId)).value?.id;

    if (currentConversationId == null) return;

    final currentUserId = ref.read(currentUserProvider).value?.id;

    if (currentUserId == null) return;

    ref.read(createPromptProvider.notifier).createPrompt(
          text: text,
          createdBy: currentUserId,
          conversationId: currentConversationId,
          isHuman: true,
        );
  }

  // void _onCancel() {
  //   logDebug('onCancel');

  //   ref.read(promptReplyProvider.notifier).stopInference();
  // }
}
