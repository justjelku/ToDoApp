import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Map<String, dynamic>> todolist = [];

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
