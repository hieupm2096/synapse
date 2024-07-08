import 'package:flutter/cupertino.dart';

class ListLlmEmpty extends StatelessWidget {
  const ListLlmEmpty({
    super.key,
    this.onAdd,
  });

  final VoidCallback? onAdd;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
