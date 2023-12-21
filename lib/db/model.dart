class Model {
  final String? name;
  final int? age;
  final int? id;
  final String? batch;

  Model(
      {required this.name,
      required this.age,
      required this.id,
      required this.batch});
  factory Model.fromJson(Map<String, dynamic> json) => Model(
      name: json['name'],
      age: json['age'],
      id: json['id'],
      batch: json['batch']);
}
