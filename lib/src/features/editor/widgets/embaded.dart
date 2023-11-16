import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';

Widget EmbedBuilder(BuildContext context, EmbedNode node) {
  if (node.value.type == 'hr') {
    final theme = FleatherTheme.of(context)!;
    return Divider(
      height: theme.paragraph.style.fontSize! * theme.paragraph.style.height!,
      thickness: 2,
      color: Colors.grey.shade200,
    );
  }

  if (node.value.type == 'icon') {
    final data = node.value.data;
    Icons.rocket_launch_outlined;
    return Icon(
      IconData(int.parse(data['codePoint']), fontFamily: data['fontFamily']),
      color: Color(int.parse(data['color'])),
      size: 18,
    );
  }

  if (node.value.type == 'image' &&
      node.value.data['source_type'] == 'assets') {
    return Padding(
      // Caret takes 2 pixels, hence not symmetric padding values.
      padding: const EdgeInsets.only(left: 4, right: 2, top: 2, bottom: 2),
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(node.value.data['source']),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  throw UnimplementedError();
}
