import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeline/src/features/home/controller/home_controller.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../editor/screens/editor.dart';

class MyTimeLine extends ConsumerWidget {
  static const String routeName = '/home';
  const MyTimeLine({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<String> notes = ref.watch(noteProvider).notes;

    Widget buildTimeLine() => ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            bool isEven = (index % 2 == 0);

            return Stack(
              fit: StackFit.passthrough,
              children: <Widget>[
                TimelineTile(
                  alignment: TimelineAlign.center,
                  beforeLineStyle: const LineStyle(
                    color: Color.fromARGB(77, 82, 80, 80),
                    thickness: 6,
                  ),
                  indicatorStyle: IndicatorStyle(
                      height: 20,
                      color: isEven
                          ? Colors.amberAccent
                          : Colors.lightGreenAccent),
                  endChild: isEven
                      ? const SizedBox()
                      : Container(
                          color: Colors.green,
                          height: 120,
                          child: Center(
                              child: Text(
                            notes[index],
                            style: const TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                            ),
                          )),
                        ),
                  startChild: isEven
                      ? Container(
                          color: Colors.amberAccent,
                          height: 120,
                          child: Center(
                              child: Text(
                            notes[index],
                            style: const TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                            ),
                          )),
                        )
                      : const SizedBox(),
                ),
                Positioned(
                    top: 48,
                    left: MediaQuery.sizeOf(context).width / 2 - 15,
                    child: ClipOval(
                      child: Container(
                        width: 30, // Set the width of the circular container
                        height: 30, // Set the height of the circular container
                        color: isEven ? Colors.amberAccent : Colors.green,
                        child: Center(
                          child: Text(
                            notes[index],
                            style: TextStyle(
                              fontSize: 15,
                              color: isEven ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )),
              ],
            );
          },
        );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TimeLine',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: buildTimeLine(),
      // Column(
      //   children: [
      //     TimelineTile(
      //       alignment: TimelineAlign.center,
      //       endChild: Container(
      //         constraints: const BoxConstraints(
      //           minHeight: 120,
      //         ),
      //         color: Colors.lightGreenAccent,
      //       ),
      //       startChild: Container(
      //         color: Colors.amberAccent,
      //       ),
      //     ),
      //     const TimelineDivider(
      //       begin: 0.1,
      //       end: 0.9,
      //       thickness: 6,
      //       color: Colors.deepOrange,
      //     ),
      //     TimelineTile(
      //       alignment: TimelineAlign.center,
      //       endChild: Container(
      //         constraints: const BoxConstraints(
      //           minHeight: 120,
      //         ),
      //         color: Colors.lightGreenAccent,
      //       ),
      //       startChild: Container(
      //         color: Colors.amberAccent,
      //       ),
      //     ),
      //     TimelineTile(
      //       //axis: TimelineAxis.horizontal,
      //       alignment: TimelineAlign.manual,
      //       lineXY: 0.1,
      //       isLast: true,
      //       beforeLineStyle: const LineStyle(
      //         color: Colors.deepOrange,
      //         thickness: 6,
      //       ),
      //       indicatorStyle: const IndicatorStyle(
      //         height: 20,
      //         color: Colors.red,
      //       ),
      //     ),
      //   ],
      // ),
      // body: FutureBuilder<List<Note>>(
      //   future: ref.read(noteProvider).getNotes(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     } else {
      //       final notes = snapshot.data!;
      //       return ListView.builder(
      //         itemCount: notes.length,
      //         itemBuilder: (context, index) {
      //           return ListTile(
      //             title: Text(notes[index].title),
      //             subtitle: Text(notes[index].note),
      //             trailing: IconButton(
      //               icon: Icon(Icons.delete),
      //               onPressed: () {
      //                 ref.read(noteProvider).deleteNote(notes[index].id);
      //               },
      //             ),
      //           );
      //         },
      //       );
      //     }
      //   },
      // ),
      floatingActionButton: InkWell(
        onLongPress: () {
          ref.read(noteProvider).clear();
        },
        child: FloatingActionButton(
          onPressed: () {
            // Navigate to screen to add new note
            //ref.read(noteProvider).add();
            Navigator.pushNamed(context, MobileEditor.routeName);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
