import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/app.dart';
import 'package:synapse/core/extension/build_context_ext.dart';
import 'package:synapse/feature/chat/provider/create_prompt_provider.dart';
import 'package:synapse/feature/chat/widget/chat_input.dart';

class TypeAndSend extends ConsumerStatefulWidget {
  const TypeAndSend({
    super.key,
  });

  @override
  ConsumerState<TypeAndSend> createState() => _TypeAndSendState();
}

class _TypeAndSendState extends ConsumerState<TypeAndSend> {
  bool _isTextEmpty = true;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(
      () {
        _onChange(_controller.text);
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 4, 8),
      decoration: BoxDecoration(
        color: context.shadColor.background,
        border: Border(top: BorderSide(color: context.shadColor.border)),
      ),
      child: SafeArea(
        child: CallbackShortcuts(
          bindings: {
            const SingleActivator(LogicalKeyboardKey.enter): _onSend,
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: ChatInput(controller: _controller),
                ),
              ),
              ShadButton.ghost(
                onPressed: () {},
                icon: const Icon(
                  LucideIcons.paperclip,
                  size: 22,
                ),
              ),
              if (_isTextEmpty)
                ShadButton.ghost(
                  onPressed: () {},
                  icon: const Icon(LucideIcons.mic),
                )
              else
                ShadButton.ghost(
                  onPressed: _onSend,
                  icon: const Icon(LucideIcons.sendHorizontal, size: 22),
                  size: ShadButtonSize.lg,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _onChange(String v) {
    setState(() {
      _isTextEmpty = v.isEmpty;
    });
  }

  void _onSend() {
    logDebug('onSend');

    FocusScope.of(context).unfocus();

    final text = _controller.text.trim();

    _controller.clear();

    if (text.isEmpty) return;

    final currentLlmId = ref.read(currentLlmProvider).value?.id;

    if (currentLlmId == null) return;

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
}
