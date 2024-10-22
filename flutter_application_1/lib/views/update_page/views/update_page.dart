import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/home_screen/modal/modal.dart';
import 'package:flutter_application_1/views/home_screen/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController txtname = TextEditingController();
    TextEditingController txtlast_name = TextEditingController();
    TextEditingController txt_contact = TextEditingController();
    TextEditingController txt_mail = TextEditingController();
    TextEditingController txt_com_name = TextEditingController();

    ContactModal model =
        ModalRoute.of(context)!.settings.arguments as ContactModal;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Contact"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                (!context.read<HomeProvider>().ishide)
                    ? PopupMenuItem(
                        child: TextButton(
                            onPressed: () {
                              context.read<HomeProvider>().ishide = true;
                              context.read<HomeProvider>().hideContact(model);
                            },
                            child: Text("Hide")))
                    : PopupMenuItem(
                        child: TextButton(
                            onPressed: () {
                              context.read<HomeProvider>().ishide = false;
                              context.read<HomeProvider>().unhideContact(model);
                            },
                            child: Text("UnHide")))
              ];
            },
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 100,
                backgroundImage:
                    model.image != null ? FileImage(File(model.image!)) : null,
              ),
              ListTile(
                title: const Text("Name"),
                subtitle: Text(model.name!),
              ),
              ListTile(
                title: const Text("Last Name"),
                subtitle: Text(model.last_name!),
              ),
              ListTile(
                title: const Text("Contact"),
                subtitle: Text(model.number!),
              ),
              ListTile(
                title: const Text("E-mail"),
                subtitle: Text(model.email!),
              ),
              ListTile(
                title: const Text("Company"),
                subtitle: Text(model.company!),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () async {
                        await launchUrl(Uri.parse("tel: ${model.number}"));
                      },
                      icon: Icon(Icons.call)),
                  IconButton(onPressed: () {}, icon: Icon(Icons.email)),
                  IconButton(
                      onPressed: () {
                        Share.share("${model.name}\n${model.number}");
                      },
                      icon: Icon(Icons.share)),
                  IconButton(
                      onPressed: () {
                        txtname.text = model.name!;
                        txt_mail.text = model.email!;
                        txt_contact.text = model.number!;
                        txtlast_name.text = model.last_name!;
                        txt_com_name.text = model.company!;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Expanded(
                              child: AlertDialog(
                                title: const Text("Edit Contact "),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: TextField(
                                          controller: txtname,
                                          decoration: const InputDecoration(
                                              hintText: "Name",
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: TextField(
                                          controller: txtlast_name,
                                          decoration: const InputDecoration(
                                              hintText: "Last Name",
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: TextField(
                                          controller: txt_contact,
                                          decoration: const InputDecoration(
                                              hintText: "Contact",
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: TextField(
                                          controller: txt_mail,
                                          decoration: const InputDecoration(
                                              hintText: "E-mail",
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: TextField(
                                          controller: txt_com_name,
                                          decoration: const InputDecoration(
                                              hintText: "Company",
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel")),
                                          TextButton(
                                              onPressed: () {
                                                ContactModal model = ContactModal(
                                                    company: txt_com_name.text,
                                                    last_name: txtlast_name.text,
                                                    name: txtname.text,
                                                    email: txt_mail.text,
                                                    number: txt_contact.text);
                                                              
                                                if(!context.read<HomeProvider>().ishide)
                                                {
                                                  context
                                                    .read<HomeProvider>()
                                                    .UpdateContact(model);
                                                Navigator.pop(context);
                                                }
                                                else{
                                                  context
                                                    .read<HomeProvider>()
                                                    .HideContactUpdate(model);
                                                Navigator.pop(context);
                                                }
                                              },
                                              child: const Text("Save"))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.edit)),
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Delete Contact?"),
                              content: Text(
                                  "This contact will be permanently deleted from your device "),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel")),
                                ElevatedButton(
                                    onPressed: () {
                                      if(!context.read<HomeProvider>().ishide)
                                      {
                                        context
                                          .read<HomeProvider>()
                                          .removeContact();
                                      Navigator.pop(context);
                                      }
                                      else{
                                        context
                                          .read<HomeProvider>()
                                          .removehideContact();
                                      Navigator.pop(context);
                                      }
                                    },
                                    child: Text("Delete"))
                              ],
                            );
                          },
                        );
                      },
                      icon: Icon(Icons.delete))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
