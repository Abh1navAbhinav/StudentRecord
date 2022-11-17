import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_student_record/functions/fuctions.dart';
import 'package:project_student_record/screens/student_detail.dart';

class SearchProfile extends SearchDelegate {
  final controllerObj = Get.put(StudentController());

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return GetBuilder<StudentController>(
      builder: (controller) => ListView.separated(
        itemBuilder: (ctx, index) {
          final data = controllerObj.studentListNotifier[index];
          if (query == data.name.toLowerCase() ||
              query == data.name.toUpperCase()) {
            return ListTile(
                leading: const Icon(Icons.person),
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      (MaterialPageRoute(builder: (ctx) {
                        return StudentDetail(
                          data: data,
                          index: index,
                        );
                      })),
                      (route) => false);
                },
                title: Text(data.name.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    )));
          } else {
            return const SizedBox();
          }
        },
        separatorBuilder: (context, value) {
          return const SizedBox(
            height: 0,
            width: 0,
          );
        },
        itemCount: controllerObj.studentListNotifier.length,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return GetBuilder<StudentController>(
      builder: (controller) => ListView.separated(
        itemBuilder: (ctx, index) {
          final data = controllerObj.studentListNotifier[index];
          if (data.name.toLowerCase().contains(query) ||
              data.name.toUpperCase().contains(query)) {
            return ListTile(
                leading: const Icon(Icons.person),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    (MaterialPageRoute(builder: (ctx) {
                      return StudentDetail(
                        data: data,
                        index: index,
                      );
                    })),
                  );
                },
                title: Text(data.name.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                    )));
          } else {
            return Container();
          }
        },
        separatorBuilder: (context, value) {
          return const SizedBox(
            height: 0,
            width: 0,
          );
        },
        itemCount: controllerObj.studentListNotifier.length,
      ),
    );
  }
}
