import 'package:flutter/cupertino.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';
import 'package:synapse/feature/llm/widget/llm_item.dart';

class ListLlm extends StatelessWidget {
  const ListLlm({
    required this.data,
    super.key,
    this.activeLlmId,
  });

  final String? activeLlmId;
  final List<LlmModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
      itemBuilder: (context, index) => LlmItem(model: data[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: data.length,
    );
  }
}
