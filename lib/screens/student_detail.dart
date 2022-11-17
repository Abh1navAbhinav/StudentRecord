import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_student_record/functions/fuctions.dart';
import 'package:project_student_record/model/data_model.dart';
import 'package:project_student_record/screens/list.dart';

// ignore: must_be_immutable
class StudentDetail extends StatelessWidget {
  StudentModel data;
  int? index;

  StudentDetail({Key? key, required this.data, required this.index})
      : super(key: key);

  var imagedetails = ''.obs;

  final controllerObj = Get.put(StudentController());

  final _isEnable = false.obs;

  final formkey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _ageController = TextEditingController();

  final _domainController = TextEditingController();

  final _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = data.name.toString();
    _ageController.text = data.age.toString();
    _domainController.text = data.domain.toString();
    _numberController.text = data.number.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${_nameController.text}\'s Detail',
          style: GoogleFonts.quicksand(
            fontWeight: FontWeight.w900,
            fontSize: 20,
            color: Colors.black54,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              changeToTrue();
            },
            icon: const Icon(Icons.edit, color: Colors.black87),
          ),
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                        height: 25,
                      ),
                      Obx(
                        () => Visibility(
                          visible: !_isEnable.value,
                          replacement: GestureDetector(
                            onTap: (() {
                              pickImage();
                            }),
                            child: imageProfile(),
                          ),
                          child: CircleAvatar(
                            backgroundImage: MemoryImage(
                              const Base64Decoder().convert(data.pic),
                            ),
                            radius: 90,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => TextFormField(
                          controller: _nameController,
                          enabled: _isEnable.value,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'numbers are not allowed',
                            hintStyle: TextStyle(color: Colors.grey),
                            label: Text(
                              ' Name',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            labelStyle: TextStyle(
                              fontSize: 25,
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => TextFormField(
                          controller: _ageController,
                          enabled: _isEnable.value,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'only two numbers are allowed',
                            hintStyle: TextStyle(color: Colors.grey),
                            label: Text(
                              ' Age',
                              style: TextStyle(color: Colors.black),
                            ),
                            labelStyle: TextStyle(
                              fontSize: 25,
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => TextFormField(
                          controller: _domainController,
                          enabled: _isEnable.value,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'enter student domain',
                            hintStyle: TextStyle(color: Colors.grey),
                            label: Text(
                              ' Domain',
                              style: TextStyle(color: Colors.black),
                            ),
                            labelStyle: TextStyle(
                              fontSize: 25,
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
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Obx(
                        () => TextFormField(
                          controller: _numberController,
                          enabled: _isEnable.value,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'mobile number should be 10 digits',
                            hintStyle: TextStyle(color: Colors.grey),
                            label: Text(
                              ' Contact Number',
                              style: TextStyle(color: Colors.black),
                            ),
                            labelStyle: TextStyle(
                              wordSpacing: 10,
                              fontSize: 25,
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
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Obx(
                        () => Visibility(
                          visible: _isEnable.value,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                updateButton(context: context);
                              }
                            },
                            icon: const Icon(
                              Icons.arrow_upward,
                              color: Colors.green,
                            ),
                            label: const Text(
                              'Update',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
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

  changeToTrue() {
    if (_isEnable.value == false) {
      _isEnable.value = true;
    } else {
      _isEnable.value = false;
    }
  }

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTemporary = File(image.path).readAsBytesSync();

      imagedetails.value = base64Encode(imageTemporary);
    }
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          Obx(
            () => CircleAvatar(
              radius: 90,
              backgroundImage: MemoryImage(
                const Base64Decoder().convert(imagedetails.value),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> updateButton({required context}) async {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    final domain = _domainController.text.trim();
    final phone = _numberController.text.trim();
    final pic = imagedetails;
    final student = StudentModel(
        name: name, age: age, domain: domain, number: phone, pic: pic.value);

    if (pic.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.amber,
          content: Padding(
            padding: EdgeInsets.only(left: 90),
            child: Text(
              'Image is empty',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
          )));
    } else {
      controllerObj.updateDetails(data: student, index: index);
      Get.offAll(() => ListScreen());
      controllerObj.getAllStudent();
    }
  }
}
