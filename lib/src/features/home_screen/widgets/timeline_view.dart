import 'package:flutter/material.dart';
import 'package:timeline/src/extensions/extensions.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../take_note/models/note_model.dart';

class TimeViewWidget extends StatelessWidget {
  List<NoteModel> notes;
  TimeViewWidget({
    Key? key,
    required this.notes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      reverse: true,
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
                  color: isEven ? Colors.amberAccent : Colors.lightGreenAccent),
              endChild: isEven
                  ? const SizedBox()
                  : Container(
                      color: Colors.green.withOpacity(.5),
                      padding: EdgeInsets.all(10),
                      height: 120,
                      child: Center(
                          child: Text(
                        notes[index].note.extractPlainText(),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )),
                    ),
              startChild: isEven
                  ? Container(
                      color: Colors.amberAccent.withOpacity(.3),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      height: 120,
                      child: Center(
                          child: Text(
                        notes[index].note.extractPlainText(),
                        style: const TextStyle(
                          fontSize: 18,
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
                    width: 30,
                    height: 30,
                    color: isEven ? Colors.amberAccent : Colors.green,
                    child: Center(
                      child: Text(
                        notes[index].id.toString(),
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
  }
}
