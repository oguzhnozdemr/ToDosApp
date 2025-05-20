import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/todos.dart';
import '../cubits/main_cubit.dart';
import '../tools/app_colors.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  var list = [
    "agac.png",
    "araba.png",
    "cicek.png",
    "damla.png",
    "gezegen.png",
    "gunes.png",
    "roket.png",
    "semsiye.png",
    "simsek.png",
    "yildiz.png"
  ];
  var image = "agac.png";
  var tfName = TextEditingController();

  @override
  void initState() {
    super.initState();
    image = list[Random().nextInt(list.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
        backgroundColor: mainColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "images/$image",
              width: 100,
              height: 100,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: TextField(
                controller: tfName,
                decoration: const InputDecoration(hintText: "Name"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<MainCubit>().insert(
                      ToDos(
                        id: 0,
                        name: tfName.text,
                        image: image,
                      ),
                    );
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
