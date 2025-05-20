import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/todos.dart';
import '../cubits/main_cubit.dart';
import '../tools/app_colors.dart';

class UpdateScreen extends StatefulWidget {
  final ToDos todo;

  const UpdateScreen({super.key, required this.todo});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  var tfName = TextEditingController();

  @override
  void initState() {
    super.initState();
    tfName.text = widget.todo.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Todo"),
        backgroundColor: mainColor,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              "images/${widget.todo.image}",
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
                context.read<MainCubit>().update(
                      ToDos(
                        id: widget.todo.id,
                        name: tfName.text,
                        image: widget.todo.image,
                      ),
                    );
                Navigator.pop(context);
              },
              child: const Text("Update"),
            ),
          ],
        ),
      ),
    );
  }
}
