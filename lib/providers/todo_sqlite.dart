import 'package:sqflite/sqflite.dart';
import 'package:todo_sqlite/models/todo.dart';

class TodoSqlite {
  late Database db;

  Future initDb() async {
    // MissingPluginError 발생하면 앱 중지/ 앱 삭제 후 다시 빌드
    db = await openDatabase('my_db.db'); //'my_db.db: 기기 내의 데이터베이스 파일의 이름
    await db.execute(
      'CREATE TABLE IF NOT EXISTS myTodo (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, title TEXT, description TEXT)',
    );//테이블 생성
  }

  Future<List<Todo>> getTodos() async {
    List<Todo> todos = [];
    List<Map> maps =
        await db.query('MyTodo', columns: ['id', 'title', 'description']);
    maps.forEach((map) {
      todos.add(Todo.fromMap(map));
    });
    return todos;
  }

  Future<Todo?> getTodo(int id) async {
    List<Map> map = await db.query('MyTodo',
        columns: ['id', 'title', 'description'],
        where: 'id=?',
        whereArgs: [id]);
    if (map.length > 0) {
      return Todo.fromMap(map[0]);
    }
  }

  Future addTodo(Todo todo) async {
    int id = await db.insert('MyTodo', todo.toMap());
  }

  Future delteTodo(int id) async {
    await db.delete('MyTodo', where: 'id=?', whereArgs: [id]);
  }

  Future updateTodo(Todo todo) async {
    await db
        .update('MyTodo', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }
}
