import '../entity/todos.dart';
import '../sqlite/database_helper.dart';

class ToDosDaoRepository {

  Future<List<ToDos>> loadToDos() async {
    var db = await DatabaseHelper.veritabaniErisim();
    var todos = await db.query("todos");
    return todos.map((map) => ToDos.fromJson(map)).toList();
  }

  Future<List<ToDos>> search(String searchText) async {
    var db = await DatabaseHelper.veritabaniErisim();
    var todos = await db.query("todos");
    return todos
        .map((map) => ToDos.fromJson(map))
        .where((todo) =>
            todo.name.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  Future<void> delete(int id) async {
    var db = await DatabaseHelper.veritabaniErisim();
    await db.delete(
      "todos",
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> update(int id, String name) async {
    var db = await DatabaseHelper.veritabaniErisim();
    await db.update(
      "todos",
      {"name": name},
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> save(String name, String image) async {
    var db = await DatabaseHelper.veritabaniErisim();
    await db.insert(
      "todos",
      {
        "name": name,
        "image": image,
      },
    );
  }
}
