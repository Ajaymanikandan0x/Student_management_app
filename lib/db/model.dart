class Model {
  final String? name;
  final int? age;
  final int? student_id;
  final String? batch;
  final String? picture;

  Model(
      {required this.name,
      required this.age,
      required this.student_id,
      required this.batch,
      this.picture});

  factory Model.fromMap(Map<String, dynamic> Map) => Model(
      name: Map['name'],
      age: Map['age'],
      student_id: Map['student_id'],
      batch: Map['batch'],
      picture: Map['picture']);

  Map<String, dynamic> toMap() => {
        'name': name,
        'age': age,
        'student_id': student_id,
        'batch': batch,
        'picture': picture,
      };
}
