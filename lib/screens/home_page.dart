import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notesfrontend/providers/note_provider.dart';
import 'package:notesfrontend/screens/screen.dart';
import 'package:provider/provider.dart';

import '../model/Notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String serachQuery = "";

  @override
  Widget build(BuildContext context) {
    NoteProvider noteProvider = Provider.of<NoteProvider>(context);
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
        centerTitle: true,
      ),
      body: (noteProvider.isLoading == false)
          ? Container(
              child: noteProvider.notes.isNotEmpty
                  ? ListView(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          onChanged: (val) {
                            setState(() {
                              serachQuery = val;
                              print(serachQuery);
                            });
                          },
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          decoration: const InputDecoration(
                              hintText: "Search Title/Content",
                              border: InputBorder.none),
                        ),
                      ),
                      noteProvider.filterNotes(serachQuery).isNotEmpty
                          ? GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2),
                              itemCount:
                                  noteProvider.filterNotes(serachQuery).length,
                              itemBuilder: (context, index) {
                                Notes currentNote = noteProvider
                                    .filterNotes(serachQuery)[index];
                                return GestureDetector(
                                  onTap: () {
                                    //update
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            fullscreenDialog: true,
                                            builder: ((context) => AddNewNote(
                                                  isUpdate: true,
                                                  notes: currentNote,
                                                ))));
                                  },
                                  onLongPress: () {
                                    //delete note
                                    noteProvider.deleteNotes(currentNote);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.grey,
                                        )),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentNote.title!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          currentNote.content!,
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.grey, fontSize: 18),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              })
                          : const Padding(
                              padding: EdgeInsets.all(10),
                              child: Center(child: Text("No Notes found!")))
                    ])
                  : const Center(
                      child: Text("No Notes Created Yet"),
                    ))
          : const Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: ((context) => const AddNewNote(
                        isUpdate: false,
                      ))));
        },
        child: const Icon(Icons.add),
      ),
    ));
  }
}
