import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/app/provider/current_llm/current_llm_provider.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/chat/widget/chat_bubble.dart';
import 'package:synapse/feature/conversation/page/list_conversation_page.dart';
import 'package:synapse/feature/llm/provider/download_llm_provider.dart';
import 'package:synapse/feature/llm/provider/list_llm_provider.dart';
import 'package:synapse/feature/llm/provider/pick_llm_provider.dart';
import 'package:synapse/feature/onboard/widget/bottom_fake_chat.dart';
import 'package:synapse/feature/onboard/widget/chat_download_progress.dart';
import 'package:synapse/feature/onboard/widget/hi_there.dart';
import 'package:synapse/feature/onboard/widget/intro_bubble_chat.dart';
import 'package:synapse/feature/setting/page/setting_page.dart';
import 'package:synapse/shared/widget/page/chat_app_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OnboardPage extends ConsumerWidget {
  const OnboardPage({super.key});

  static const String route = '/onboard';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref
      ..listen(
        pickLlmProvider,
        (previous, next) {
          if (next.hasError && next.error != null) {
            if (next.error?.toString() == 'invalid') {
              context.shadToaster.show(
                ShadToast.destructive(
                  title: const Text('Invalid file'),
                  description: const Text('File must has GGUF format.'),
                  titleStyle: context.shadTextTheme.small,
                  duration: 2.seconds,
                  showCloseIconOnlyWhenHovered: false,
                ),
              );
            }
          } else if (next.hasValue && next.value != null) {
            ref
                .read(listLLMAsyncNotifierProvider.notifier)
                .addLlmModel(data: next.value!);

            ref.read(currentLlmProvider.notifier).setLlmModel(next.value!);

            context.go(ListConversationPage.route);
          }
        },
      )
      ..listen(
        downloadLlmProvider,
        (previous, next) {
          if (next.hasValue && next.value != null) {
            final value = next.value;

            if (value is DownloadLlmSuccess) {
              context.shadToaster.show(
                ShadToast(
                  description: Text('${value.llmId} downloaded successfully'),
                  duration: 2.seconds,
                  showCloseIconOnlyWhenHovered: false,
                ),
              );

              // go to ListConversationPage
              context.go(ListConversationPage.route);
            }
          }
        },
      );

    final asyncDownloadLlm = ref.watch(downloadLlmProvider);

    return Scaffold(
      appBar: ChatAppBar(
        title: Text('Welcome', style: context.shadTextTheme.h4),
        showLeading: false,
        onSettingPressed: () => context.push(SettingPage.route),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
              reverse: true,
              child: const HiThere()
                  .animate(delay: 2500.ms)
                  .fadeOut(duration: 250.ms)
                  .swap(
                builder: (context, child) {
                  return Column(
                    children: [
                      IntroBubbleChat(
                        onDownloadTap: asyncDownloadLlm.valueOrNull != null
                            ? () {
                                ref
                                    .read(downloadLlmProvider.notifier)
                                    .downloadDefaultLlmModel();
                              }
                            : null,
                        onSelectTap: () {
                          ref.read(pickLlmProvider.notifier).pickLlm();
                        },
                      ),

                      const SizedBox(height: 16),

                      // DOWNLOAD RELATED SECTION
                      asyncDownloadLlm.when(
                        data: (data) {
                          final isDownloading = data.taskSet.isNotEmpty;

                          if (!isDownloading) {
                            return const SizedBox.shrink();
                          }

                          return ChatBubble.right(
                            content: 'Download model',
                          );
                        },
                        error: (error, stackTrace) => const SizedBox.shrink(),
                        loading: SizedBox.shrink,
                      ),

                      const SizedBox(height: 16),

                      asyncDownloadLlm
                          .when(
                            data: (data) {
                              final isDownloading = data.taskSet.isNotEmpty;

                              if (!isDownloading) {
                                return const SizedBox.shrink();
                              }

                              return ChatBubble.left(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          'Downloading',
                                          style: context.shadTextTheme.h4,
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            for (var i = 0; i < 3; i++)
                                              Text(
                                                '.',
                                                style: context.shadTextTheme.h4,
                                              )
                                                  .animate(
                                                    onComplete: (controller) =>
                                                        controller.repeat(),
                                                  )
                                                  .fadeIn(
                                                    delay: (i * 250).ms,
                                                    duration: 250.ms,
                                                  )
                                                  .then(
                                                    delay: ((2 - i) * 250).ms,
                                                  )
                                                  .fadeOut(duration: 250.ms),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    GestureDetector(
                                      onTap: () {
                                        launchUrlString(
                                          'https://huggingface.co/microsoft/Phi-3-mini-4k-instruct',
                                        );
                                      },
                                      child: Text(
                                        'microsoft/Phi-3-mini-4k-instruct',
                                        style:
                                            context.shadTextTheme.list.copyWith(
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '''Your download is on its way. Thank you for your patience.''',
                                      style: context.shadTextTheme.p,
                                    ),
                                    const SizedBox(height: 32),
                                    const ChatDownloadProgress(),
                                  ],
                                ),
                              );
                            },
                            error: (error, stackTrace) {
                              return ChatBubble.left(content: error.toString());
                            },
                            loading: SizedBox.shrink,
                          )
                          .animate()
                          .fadeIn(
                            delay: 100.ms,
                            duration: 200.ms,
                          ),
                    ],
                  ).animate().fadeIn(begin: 0, duration: 200.ms);
                },
              ),
            ),

            // Typing
            const Align(
              alignment: Alignment.bottomCenter,
              child: BottomFakeChat(),
            ),
          ],
        ),
      ),
    );
  }
}
