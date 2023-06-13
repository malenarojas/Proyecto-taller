class Band1 {
  String id;
  String name;
  int votes;

  Band1({required this.id, required this.name, required this.votes});

  factory Band1.fromMap(Map<String, dynamic> obj) => Band1(
      id: obj.containsKey('id') ? obj['id'] : 'no-id',
      name: obj.containsKey('name') ? obj['name'] : 'no-name',
      votes: obj.containsKey('votes') ? obj['votes'] : 'no-votes');
}
