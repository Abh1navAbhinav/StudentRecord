// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_student_record/functions/fuctions.dart';
import 'package:project_student_record/model/data_model.dart';

// ignore: must_be_immutable
class AddStudent extends StatelessWidget {
  AddStudent({Key? key}) : super(key: key);
  final imageadd = ''.obs;

  final formkey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _domainController = TextEditingController();

  final _numberController = TextEditingController();
  final controllerObj = Get.put(StudentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.backspace,
            color: Colors.black87,
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(
            left: 20,
          ),
          child: Text(
            'Add a new Student',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: (() {
                          pickImage();
                        }),
                        child: imageProfile(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'numbers are not allowed',
                          hintStyle: TextStyle(color: Colors.grey),
                          label: Text(
                            'Student Name',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name should not be empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "only two numbers are allowed",
                          hintStyle: TextStyle(color: Colors.grey),
                          label: Text(
                            'Student Age',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Age should not be empty';
                          } else if (value.length > 2) {
                            return 'invalid age';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _domainController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'enter student domain',
                          hintStyle: TextStyle(color: Colors.grey),
                          label: Text(
                            'Student Domain',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Domain should not be empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        controller: _numberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'mobile number should be 10 digits',
                          hintStyle: TextStyle(color: Colors.grey),
                          label: Text(
                            'Student Number',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Number should not be empty';
                          } else if (value.length != 10) {
                            return 'invalid mobile number';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            submitButton(context: context);
                          }
                        },
                        icon: const Icon(
                          Icons.check,
                        ),
                        label: const Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> submitButton({required context}) async {
    final pic = imageadd;
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final domain = _domainController.text.trim();
    final number = _numberController.text.trim();

    if (pic.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.amber,
          content: Padding(
            padding: EdgeInsets.only(left: 90),
            child: Text(
              'Image is empty',
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
      );
    } else {
      final student = StudentModel(
          name: name, age: age, domain: domain, number: number, pic: pic.value);
      controllerObj.addStudent(student);
      Navigator.pop(context);
    }
  }

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTemporary = File(image.path).readAsBytesSync();

      imageadd.value = base64Encode(imageTemporary);
    }
  }

  Widget imageProfile() {
    return Center(
      child: Stack(children: [
        Obx(
          () => CircleAvatar(
            radius: 90,
            backgroundImage: MemoryImage(
              const Base64Decoder().convert(imageadd.value),
            ),
          ),
        ),
        const Positioned(
          bottom: 135,
          right: 130,
          child: Icon(
            Icons.add_a_photo_rounded,
            size: 50,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        )
      ]),
    );
  }
}
