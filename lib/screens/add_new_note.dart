import 'package:flutter/material.dart';
import 'package:notesfrontend/providers/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../model/Notes.dart';

class AddNewNote extends StatefulWidget {
  final bool isUpdate;
  final Notes? notes;
  const AddNewNote({Key? key, required this.isUpdate, this.notes})
      : super(key: key);

  @override
  State<AddNewNote> createState() => _AddNewNoteState();
}

class _AddNewNoteState extends State<AddNewNote> {
  FocusNode noteFocus = FocusNode();
  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  void addNotes() {
    Notes note = Notes(
        id: const Uuid().v1(),
        title: titleController.text,
        content: notesController.text,
        userid: "rohitarora",
        dataAdded: DateTime.now());

    Provider.of<NoteProvider>(context, listen: false).addNotes(note);
    Navigator.pop(context);
  }

  void updateNotes() {
    widget.notes!.title = titleController.text;
    widget.notes!.content = notesController.text;
    widget.notes!.dataAdded = DateTime.now();
    Provider.of<NoteProvider>(context, listen: false)
        .updateNotes(widget.notes!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();

    if (widget.isUpdate) {
      titleController.text = widget.notes!.title!;
      notesController.text = widget.notes!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    if (widget.isUpdate) {
                      updateNotes();
                    } else {
                      addNotes();
                    }
                  },
                  icon: Icon(Icons.check))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                TextField(
                  controller: titleController,
                  autofocus: widget.isUpdate == true ? false : true,
                  onSubmitted: (val) {
                    if (val != "") {
                      noteFocus.requestFocus();
                    }
                  },
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                      hintText: "Title", border: InputBorder.none),
                ),
                Expanded(
                  child: TextField(
                    controller: notesController,
                    focusNode: noteFocus,
                    maxLines: null,
                    style: const TextStyle(fontSize: 30),
                    decoration: const InputDecoration(
                        hintText: "Notes", border: InputBorder.none),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
