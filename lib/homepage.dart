import 'package:flutter/material.dart';
import 'package:todoapp_sqflite/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String, dynamic>> todolist = [];

  void _getData() async {
    final todo = await Database.getTodos();
    setState(() {
      todolist = todo;
    });
  }
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List of Todos"),
      ),
      body: ListView.builder(
        itemCount: todolist.length,
        itemBuilder: (context, index){
          return ListTile(
              leading: CircleAvatar(child: Text(todolist[index]['id'].toString())),
              title: Text(todolist[index]['title'],
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black
                ),
              ),
              subtitle: Text(todolist[index]['description'],
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black
                ),
              ),
              trailing: const Icon(
                Icons.edit,
                color: Colors.green
              ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){

        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
