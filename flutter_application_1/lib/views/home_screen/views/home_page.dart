import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/home_screen/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var model = context.read<HomeProvider>().list;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        actions: [
          IconButton(
  onPressed: () async {
    bool islock = await context.read<HomeProvider>().openlock();

    if (islock) {
      Navigator.pushNamed(context, '/hide_page');
      setState(() {
        
      });
    }
  },
  icon: const Icon(Icons.visibility),
)

        ],
      ),
      body: ListView.builder(
          itemCount: context.watch<HomeProvider>().list.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                context.read<HomeProvider>().getIndex(index);
                Navigator.pushNamed(context, '/update_page',
                    arguments: context.read<HomeProvider>().list[index]);
              },
              leading: CircleAvatar(
                backgroundImage: context
                            .watch<HomeProvider>()
                            .list[index]
                            .image !=
                        null
                    ? FileImage(
                        File(context.watch<HomeProvider>().list[index].image!))
                    : null,
              ),
              title: Text(context.watch<HomeProvider>().list[index].name!),
              subtitle: Text(context.watch<HomeProvider>().list[index].number!),
              trailing: IconButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse("tel: ${model[index].number}"));
                  },
                  icon: Icon(Icons.call)),
            );
          }),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/contact_page');
          }),
    );
  }
}
