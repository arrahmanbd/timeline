import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:timeline/src/extensions/extensions.dart';

import 'package:timeline/src/features/take_note/models/note_model.dart';

import '../../take_note/controller/editing_controller.dart';
import '../../take_note/screens/editor_screen.dart';

class SearchScreen extends ConsumerWidget {
  final List<NoteModel> noteSearch;
  const SearchScreen({
    required this.noteSearch,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController _controller = TextEditingController();
    return Column(
      children: [
        TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            autofocus: false,
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Search note...',
            ),
          ),
          suggestionsCallback: (pattern) {
            return noteSearch
                .where((noteSearch) => noteSearch.note
                    .toLowerCase()
                    .contains(pattern.toLowerCase()))
                .toList();
          },
          itemBuilder: (context, suggestion) {
            return ListTile(
              title: Text(suggestion.note.extractPlainText()),
              subtitle: Text(suggestion.edited!.formatTimeAndDay()),
            );
          },
          onSuggestionSelected: (suggestion) {
            // Handle when a suggestion is selected.
            _controller.text = suggestion.note.extractPlainText();
            print('Selected country: $suggestion');
            void openNotes(int index) {
              Navigator.pushNamed(context, EditorScreen.routeName);
              ref.read(noteController.notifier).updateNote(suggestion);
            }
          },
        ),
      ],
    );
  }
}
