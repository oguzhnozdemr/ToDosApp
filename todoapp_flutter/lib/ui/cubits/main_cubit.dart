import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/entity/todos.dart';
import '../../data/repo/todos_dao_repository.dart';

class MainCubit extends Cubit<List<ToDos>> {
  MainCubit() : super([]);
  var toDosDaoRepository = ToDosDaoRepository();

  Future<void> loadToDos() async {
    var list = await toDosDaoRepository.loadToDos();
    emit(list);
  }

  Future<void> search(String searchText) async {
    var list = await toDosDaoRepository.search(searchText);
    emit(list);
  }

  Future<void> delete(int id) async {
    await toDosDaoRepository.delete(id);
    await loadToDos();
  }

  Future<void> update(ToDos todo) async {
    await toDosDaoRepository.update(todo.id, todo.name);
    await loadToDos();
  }

  Future<void> insert(ToDos todo) async {
    await toDosDaoRepository.save(todo.name, todo.image);
    await loadToDos();
  }
}
