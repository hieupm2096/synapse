import 'package:flutter/cupertino.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:synapse/core/core.dart';
import 'package:synapse/feature/llm/model/llm_model/llm_model.dart';
import 'package:synapse/feature/llm/widget/llm_item.dart';

class ListLlm extends StatefulWidget {
  const ListLlm({
    required this.data,
    super.key,
  });

  final List<LlmModel> data;

  @override
  State<ListLlm> createState() => _ListLlmState();
}

class _ListLlmState extends State<ListLlm> {
  @override
  void initState() {
    Future.delayed(
      100.ms,
      () {
        if (widget.data.every((element) => !element.isAvailable)) {
          context.shadToaster.show(
            const ShadToast(
              title: Text('Ready to chat?'),
              description: Text('Download the model to start our conversation'),
              duration: Duration(seconds: 30),
              showCloseIconOnlyWhenHovered: false,
            ),
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
      itemBuilder: (context, index) => LlmItem(model: widget.data[index]),
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: widget.data.length,
    );
  }
}
