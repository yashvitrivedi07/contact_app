import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/home_screen/modal/modal.dart';
import 'package:flutter_application_1/views/home_screen/provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController last_nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  String? first_name , Last_name , email , company , date , contact ;
  

  int current_index = 0;
  String? path;
  @override
  Widget build(BuildContext context) {
    MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Contact"),
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stepper(
            currentStep: current_index,
            onStepContinue: () {
              setState(() {});
              if (current_index < 3) {
                current_index++;
              }
            },
            onStepCancel: () {
              setState(() {});
              if (current_index > 0) {
                current_index--;
              }
            },
            steps: [
              Step(
                  title: const Text("Add Image"),
                  content: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        child: (path == null)
                            ? IconButton(
                                onPressed: () async {
                                  ImagePicker picker = ImagePicker();
                                  XFile? file = await picker.pickImage(
                                      source: ImageSource.gallery);

                                  path = file as String?;
                                },
                                icon: const Icon(Icons.add))
                            : GestureDetector(
                                onTap: () async {
                                  ImagePicker picker = ImagePicker();
                                  XFile? file = await picker.pickImage(
                                      source: ImageSource.gallery);

                                  path = file as String?;
                                },
                                child: Image.file(File(path!))),
                      ),
                    ],
                  )),
              Step(
                  title: const Text("Name"),
                  content: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            label: Text("First name"),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: last_nameController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              label: Text("Last name"),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: contactController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              label: Text("Phone"),
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  )),
              Step(
                  title: const Text("other"),
                  content: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              label: Text("Email"),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: dateController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              label: Text("Significant date"),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          controller: companyController,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                              label: Text("Company"),
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  )),
              Step(
                  title: const Text(""),
                  content:
                      ElevatedButton(onPressed: () {
                        first_name = nameController.text;
                        Last_name = last_nameController.text;
                        company = companyController.text;
                        contact = contactController.text;
                        email = emailController.text;
                        date = dateController.text;
                        

                        ContactModal model = ContactModal(company: company , email: email , name: first_name , last_name: Last_name , number: contact , image: path );

                         
                       context.read<HomeProvider>().addContact(model);

                        
                        
                      }, child: const Text("Save")))
            ]),
      ),
    );
  }
}
