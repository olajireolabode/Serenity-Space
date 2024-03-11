class Entry {
  late int id;
  late String feeling;
  late String description;
  late String user_email;

  Entry({required this.feeling, required this.description, required this.user_email});

  Map<String, dynamic> toMap() {
    return {'feeling': feeling, 'description': description, 'user_email': user_email};
  }
}
