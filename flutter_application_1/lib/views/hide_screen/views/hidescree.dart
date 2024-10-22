import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/views/home_screen/modal/modal.dart';
import 'package:flutter_application_1/views/home_screen/provider/provider.dart';
import 'package:provider/provider.dart';

class Hidescree extends StatefulWidget {
  const Hidescree({super.key});

  @override
  State<Hidescree> createState() => _HidescreeState();
}

class _HidescreeState extends State<Hidescree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hidden Contact"),
        
      ),

      body: ListView.builder(itemCount: context.watch<HomeProvider>().hideList.length,itemBuilder: (context, index) {
        return Card(
         child: ListTile(
          onTap: () {
            Navigator.pushNamed(context, '/update_page');
            Navigator.pushNamed(context, '/update_page',arguments: context.read<HomeProvider>().hideList[index]);
          },
          title: Text(context.watch<HomeProvider>().hideList[index].name!),
          subtitle: Text(context.watch<HomeProvider>().hideList[index].number!),
         ),
        );
      },),
    );
  }
}