class Notes {
  String? id;
  String? userid;
  String? content;
  String? title;
  DateTime? dataAdded;

  Notes({this.id, this.userid, this.content, this.title, this.dataAdded});
  factory Notes.fromMap(Map<String, dynamic> map) {
    return Notes(
      id: map['id'],
      userid: map['userid'],
      title: map['title'],
      content: map['content'],
      dataAdded: DateTime.tryParse(map["dataAdded"]!),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id!,
      "userid": userid!,
      "title": title!,
      "content": content!,
      "dataAdded": dataAdded!.toIso8601String(),
    };
  }
}
