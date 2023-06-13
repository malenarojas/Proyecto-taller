class Band {
  String id;
  String name;
  String description;

  Band({required this.id, required this.name, required this.description});

  factory Band.fromMap(Map<String, dynamic> obj) => Band(
      id: obj.containsKey('id') ? obj['id'] : 'no-id',
      name: obj.containsKey('name') ? obj['name'] : 'no-name',
      description: obj.containsKey('description')
          ? obj['description']
          : 'no-description');
}
