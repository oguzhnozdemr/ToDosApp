import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todoapp_flutter/ui/screens/save_screen.dart';
import 'package:todoapp_flutter/ui/screens/update_screen.dart';

import '../../data/entity/todos.dart';
import '../companent/my_app_bar.dart';
import '../cubits/main_cubit.dart';
import '../tools/app_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MainCubit>().loadToDos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "ToDos"),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                placeholder: "Search",
                onChanged: (searchText) {
                  context.read<MainCubit>().search(searchText);
                },
              ),
            ),
            BlocBuilder<MainCubit, List<ToDos>>(
              builder: (context, todosList) {
                if (todosList.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: todosList.length,
                      itemBuilder: (context, index) {
                        var todo = todosList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateScreen(todo: todo),
                              ),
                            ).then((_) {
                              context.read<MainCubit>().loadToDos();
                            });
                          },
                          child: Card(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                    "images/${todo.image}",
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                                Text(
                                  todo.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Oswald",
                                  ),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: mainColor,
                                        content: Text(
                                          "Do you want to delete ${todo.name}?",
                                          style: TextStyle(color: textColor2),
                                        ),
                                        action: SnackBarAction(
                                          label: "Yes",
                                          textColor: textColor2,
                                          onPressed: () {
                                            context
                                                .read<MainCubit>()
                                                .delete(todo.id);
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.clear, color: textColor1),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("No todos found"),
                  );
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SaveScreen()),
          ).then((_) {
            context.read<MainCubit>().loadToDos();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
