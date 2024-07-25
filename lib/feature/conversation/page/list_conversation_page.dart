import 'package:flutter/material.dart';
import 'package:synapse/app/view/downloader_button.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/conversation/widget/list_conversation_container.dart';
import 'package:synapse/feature/conversation/widget/llm_select.dart';
import 'package:synapse/feature/conversation/widget/new_conversation_button.dart';

class ListConversationPage extends StatelessWidget {
  const ListConversationPage({super.key});

  static String route = '/conversations';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        // leading: const ShadBackButton(),
        title: Text(
          'Recent',
          style: context.shadTextTheme.h4,
        ),
        actions: const [
          NewConversationIconButton(),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.1),
          child: Divider(height: 0.1),
        ),
      ),
      floatingActionButton: const DownloaderButton(),
      body: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(8, 12, 8, 0),
                child: LlmSelect(),
              ),
            ),
            SliverFillRemaining(
              child: ListConversationContainer(),
            ),
          ],
        ),
      ),
    );
  }
}
