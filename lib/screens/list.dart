import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_student_record/functions/fuctions.dart';
import 'package:project_student_record/screens/add_student.dart';
import 'package:project_student_record/screens/search.dart';
import 'package:project_student_record/screens/student_detail.dart';

class ListScreen extends StatelessWidget {
  ListScreen({Key? key}) : super(key: key);
  final controllerObj = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Student List',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w500,
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: SearchProfile(),
                );
              },
              icon: const Icon(
                Icons.search,
                size: 35,
                color: Colors.black54,
              ),
            ),
          )
        ],
      ),
      body: GetBuilder<StudentController>(
        builder: (controller) => ListView.separated(
          itemBuilder: (ctx, index) {
            final data = controllerObj.studentListNotifier[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: CircleAvatar(
                  radius: 25,
                  backgroundImage:
                      MemoryImage(const Base64Decoder().convert(data.pic)),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  data.name,
                  style: GoogleFonts.quicksand(fontSize: 20),
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  alertBox(context, index);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Color.fromARGB(255, 255, 0, 0),
                ),
              ),
              onTap: () {
                Get.to(() => StudentDetail(data: data, index: index));
              },
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(
              height: 20,
            );
          },
          itemCount: controllerObj.studentListNotifier.length,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => AddStudent());
        },
        label: const Text(
          'Add',
          style: TextStyle(
            color: Colors.black54,
            fontSize: 25,
            fontWeight: FontWeight.w900,
          ),
        ),
        icon: const Icon(
          Icons.person_add_outlined,
          color: Colors.black,
        ),
      ),
    );
  }

  void alertBox(BuildContext ctx, index) {
    showDialog(
      context: ctx,
      builder: (ctx) {
        return AlertDialog(
          title: const Text(
            'Alert',
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
            ),
          ),
          content: const Text(
            'Item will be deleted permanently',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.green, fontSize: 20),
              ),
            ),
            TextButton(
              onPressed: () {
                controllerObj.deleteStudent(index);
                Navigator.pop(ctx);
              },
              child: const Text(
                'Delete',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
