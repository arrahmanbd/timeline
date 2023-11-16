import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline/src/features/editor/providers/state_controller.dart';
import 'package:timeline/src/features/editor/widgets/embaded.dart';

class EditorScreen extends ConsumerStatefulWidget {
  static const String routeName = '/editor';
  const EditorScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  final FocusNode _focusNode = FocusNode();
  FleatherController _controller = FleatherController();

  @override
  void initState() {
    super.initState();
    _initController();
  }

  void _initController() {
    ref.read(editorProvider.notifier).initController(_controller);
  }

  void undo() {
    ref.read(editorProvider.notifier).undo(_controller);
  }

  void _url(String? url) {
    ref.read(editorProvider.notifier).urllaunch(url);
  }

  void setText(BuildContext _context) {
    //final text = ref.read(editorProvider).jsonString;
    final put = ref.read(editorProvider.notifier).openEditor(_context);
    _controller = FleatherController(put);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(editorProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Create an story'),
        actions: [
          IconButton(onPressed: () => undo(), icon: const Icon(Icons.undo)),
          IconButton(
              onPressed: () => setText(context),
              icon: const Icon(Icons.open_in_browser)),
          IconButton(
              onPressed: () => provider.saveNote(_controller, context),
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
                        controller: _controller,
                        focusNode: _focusNode,
                        onLaunchUrl: _url,
                        maxContentWidth: 800,
                        embedBuilder: EmbedBuilder),
                  ),
                ),
              ],
            ),
    );
  }
}
