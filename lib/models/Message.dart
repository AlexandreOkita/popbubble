class Message {

  final String message;
  final Author author;
  final Event event;

  Message(this.message, this.author, this.event);

  Message.fromJson(Map<String, dynamic> json)
      : message = json['message'],
        author = Author.values.firstWhere((element) => element.toString() == "Author.${json['author']}"),
        event = Event.values.firstWhere((element) => element.toString() == "Event.${json['event']}");
}

enum Author {
  SYSTEM, PERSON
}

enum Event {
  CONNECTED, DISCONNECTED, MESSAGE
}