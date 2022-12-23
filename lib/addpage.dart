import 'package:flutter/material.dart';
import 'package:todoapp_sqflite/database.dart';

class AddPage extends StatefulWidget {
  final Map? todo;

  const AddPage({super.key, this.todo});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  List<Map<String, dynamic>> todolist = [];
  // List todoList = [];

  final formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool isEdit = false;

  get id => null;

  bool _isLoading = true;

  void _refreshData() async {
    final todo = await Database.getTodos();
    setState(() {
      todolist = todo;
      _isLoading = false;
    });
  }


  @override
  void initState() {
    super.initState();
    _refreshData();
    final todo = widget.todo;
    if (todo != null) {
      isEdit = true;
      final existingData = todolist.firstWhere((element) => element['id'] == id);
      _titleController.text = existingData['title'];
      _descriptionController.text = existingData['description'];
    } else {
      _titleController.text = "";
      _descriptionController.text = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: _titleController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Title',
                labelText: 'Title',
              ),
              validator: (value) {
                return (value == '') ? 'Fill in the blanks' : null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                  labelText: 'Description'
              ),
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 6,

              validator: (value) {
                return (value == '') ? 'Fill in the blanks' : null;
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      if (id == null) {
                        await addTodo();
                      }

                      // Clear the text fields
                      setState(() {
                        id != null;
                        _titleController.text = '';
                        _descriptionController.text = '';
                      });
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  },
                  child: Text(id != null ? 'Update' : 'Save'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

// Insert a new data to the database
  Future<void> addTodo() async {
    await Database.createTodo( //post
        _titleController.text, _descriptionController.text);
    _refreshData();
  }
}
