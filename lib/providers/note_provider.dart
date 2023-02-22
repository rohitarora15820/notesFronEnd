import 'package:flutter/cupertino.dart';
import 'package:notesfrontend/model/Notes.dart';
import 'package:notesfrontend/services/api_services.dart';

class NoteProvider with ChangeNotifier {
  bool isLoading = true;
  List<Notes> notes = [];

  NoteProvider() {
    fetchNotes();
  }
  void sortNotes() {
    notes.sort(((a, b) => b.dataAdded!.compareTo(a.dataAdded!)));
  }

  List<Notes> filterNotes(String searchQuery) {
    return notes
        .where((element) =>
            element.title!.toLowerCase().contains(searchQuery.toLowerCase()) ||
            element.content!.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  void addNotes(Notes note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiServices.addNote(note);
  }

  void deleteNotes(Notes note) {
    int indexOfNotes =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));

    notes.removeAt(indexOfNotes);
    sortNotes();
    notifyListeners();
    ApiServices.deleteNote(note);
  }

  void updateNotes(Notes note) {
    int indexOfNotes =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNotes] = note;
    sortNotes();
    notifyListeners();
    ApiServices.addNote(note);
  }

  void fetchNotes() async {
    notes = await ApiServices.fetchNote("rohitarora");
    isLoading = false;
    sortNotes();
    notifyListeners();
  }
}
