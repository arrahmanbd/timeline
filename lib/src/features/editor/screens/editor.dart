import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:quill_delta/quill_delta.dart';
import 'package:timeline/src/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

class MobileEditor extends StatefulWidget {
  static const String routeName = '/editor';
  const MobileEditor({Key? key}) : super(key: key);

  @override
  _MobileEditorState createState() => _MobileEditorState();
}

class _MobileEditorState extends State<MobileEditor> {
  final FocusNode _focusNode = FocusNode();
  FleatherController? _controller;
  String json = '';

  @override
  void initState() {
    super.initState();
    _initController();
  }

  final heuristics = ParchmentHeuristics(
    formatRules: [],
    insertRules: [
      ForceNewlineForInsertsAroundInlineImageRule(),
    ],
    deleteRules: [],
  ).merge(ParchmentHeuristics.fallback);

  Future<void> _initController() async {
    try {
      // final doc = ParchmentDocument.fromJson(
      //   jsonDecode(result),
      //   heuristics: heuristics,
      // );
      _controller = FleatherController();
    } catch (err, st) {
      print('Cannot read welcome.json: $err\n$st');
      _controller = FleatherController();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Create an story'),
        actions: [
          IconButton(
              onPressed: () {
                _controller!.undo();
                setState(() {});
              },
              icon: const Icon(Icons.undo)),
          IconButton(
              onPressed: () {
                final doc = ParchmentDocument.fromJson(
                  jsonDecode(json),
                  heuristics: heuristics,
                );
                _controller = FleatherController(doc);
                Utils.showSnackBar(content: 'Note Opeing', context: context);
                setState(() {});
              },
              icon: const Icon(Icons.open_in_browser)),
          IconButton(
              onPressed: () {
                print('This is the doc');
                json = jsonEncode(_controller!.document.toDelta().toJson());
                print(json);
                Utils.showSnackBar(content: 'Note Picked', context: context);
                setState(() {});
              },
              icon: const Icon(Icons.save))
        ],
      ),
      body: _controller == null
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                FleatherToolbar.basic(controller: _controller!),
                Divider(height: 1, thickness: 1, color: Colors.grey.shade300),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: MediaQuery.of(context).padding.bottom,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.amber),
                    ),
                    child: FleatherEditor(
                      controller: _controller!,
                      focusNode: _focusNode,
                      onLaunchUrl: _launchUrl,
                      maxContentWidth: 800,
                      embedBuilder: _embedBuilder,
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _embedBuilder(BuildContext context, EmbedNode node) {
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

  void _launchUrl(String? url) async {
    if (url == null) return;
    final uri = Uri.parse(url);
    final _canLaunch = await canLaunchUrl(uri);
    if (_canLaunch) {
      await launchUrl(uri);
    }
  }
}

/// This is an example insert rule that will insert a new line before and
/// after inline image embed.
class ForceNewlineForInsertsAroundInlineImageRule extends InsertRule {
  @override
  Delta? apply(Delta document, int index, Object data) {
    if (data is! String) return null;

    final iter = DeltaIterator(document);
    final previous = iter.skip(index);
    final target = iter.next();
    final cursorBeforeInlineEmbed = _isInlineImage(target.data);
    final cursorAfterInlineEmbed =
        previous != null && _isInlineImage(previous.data);

    if (cursorBeforeInlineEmbed || cursorAfterInlineEmbed) {
      final delta = Delta()..retain(index);
      if (cursorAfterInlineEmbed && !data.startsWith('\n')) {
        delta.insert('\n');
      }
      delta.insert(data);
      if (cursorBeforeInlineEmbed && !data.endsWith('\n')) {
        delta.insert('\n');
      }
      return delta;
    }
    return null;
  }

  bool _isInlineImage(Object data) {
    if (data is EmbeddableObject) {
      return data.type == 'image' && data.inline;
    }
    if (data is Map) {
      return data[EmbeddableObject.kTypeKey] == 'image' &&
          data[EmbeddableObject.kInlineKey];
    }
    return false;
  }
}
