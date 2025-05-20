
import 'package:todoapp_flutter/data/entity/todos.dart';


class ToDosResponse {
  List<ToDos> toDos;
  int success;

  ToDosResponse({required this.toDos,required this.success});

  factory ToDosResponse.fromJson(Map<String,dynamic> json){
    var success = json["success"] as int;
    var jsonArray = json["toDos"] as List;

    var toDos = jsonArray.map((jsonObject) => ToDos.fromJson(jsonObject)).toList();

    return ToDosResponse(toDos: toDos, success: success);
  }
}


