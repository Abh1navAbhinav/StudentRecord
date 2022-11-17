import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_student_record/model/data_model.dart';

class StudentController extends GetxController {
  List<StudentModel> studentListNotifier = [];

  Future<void> addStudent(StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    final id = await studentDB.add(value);
    value.id = id;

    studentListNotifier.add(value);
    update();
  }

  Future<void> getAllStudent() async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentListNotifier.clear();
    studentListNotifier.addAll(studentDB.values);
    update();
  }

  Future<void> deleteStudent(int index) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.deleteAt(index);
    getAllStudent();
    update();
  }

  updateDetails({required data, required index}) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.putAt(index, data);
    getAllStudent();
    update();
  }

  @override
  void onInit() {
    getAllStudent();
    super.onInit();
  }
}
