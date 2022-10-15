import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  late int? id;
  late String title;
  late String description;
  late DocumentReference? reference; //Firestore내에 저장되어 있는 문서를 가리키는 객체

  Todo({
    this.id,
    required this.title,
    required this.description,
    this.reference,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  Todo.fromMap(Map<dynamic, dynamic>? map) {
    id = map?['id'];
    title = map?['title'];
    description = map?['description'];
  }

  //Firestore에서 DocumentSnapshot이라는 형태로 데이터를 제공하며, Map<String, dynamic으로 변환, Todo로 변환해 저장
  Todo.fromSnapshot(DocumentSnapshot document){
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    id = map['id'];
    title = map['title'];
    description = map['description'];
    reference = document.reference;
  }
}
