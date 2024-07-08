import 'package:flutter/material.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/llm/widget/list_llm_container.dart';
import 'package:synapse/shared/widget/widget.dart';

class ListLlmPage extends StatelessWidget {
  const ListLlmPage({super.key});

  static String route = 'model';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: const ShadBackButton(),
        title: Text(
          'Models',
          style: context.shadTextTheme.h4,
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.1),
          child: Divider(height: 0.1),
        ),
      ),
      body: const ListLlmContainer(),
    );
  }
}
