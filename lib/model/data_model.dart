import 'package:hive_flutter/adapters.dart';
part 'data_model.g.dart';

@HiveType(typeId: 1)
class StudentModel {
  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String age;

  @HiveField(3)
  final String domain;

  @HiveField(4)
  final String number;

  @HiveField(5)
  final String pic;

  StudentModel(
      {required this.name,
      required this.age,
      required this.domain,
      required this.number,
      required this.pic,
      this.id});
}
