import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:notesfrontend/model/Notes.dart';

class ApiServices {
  static const String _baseUrl = "https://rohit-arora.onrender.com/notes";

  static Future<void> addNote(Notes notes) async {
    Uri requestUrl = Uri.parse(_baseUrl + '/add');
    var response = await http.post(requestUrl, body: notes.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<void> deleteNote(Notes notes) async {
    Uri requestUrl = Uri.parse(_baseUrl + '/delete');
    var response = await http.post(requestUrl, body: notes.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }

  static Future<List<Notes>> fetchNote(String userid) async {
    Uri requestUrl = Uri.parse(_baseUrl + '/list');
    var response = await http.post(requestUrl, body: {"userid": userid});
    var decoded = json.decode(response.body);
    List<Notes> notes = [];

    for (var noteMap in decoded) {
      Notes newNote = Notes.fromMap(noteMap);
      notes.add(newNote);
    }

    return notes;
  }
}
