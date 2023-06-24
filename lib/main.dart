import 'package:flutter/material.dart';

class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.purple[800], // Cor primária do aplicativo
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.purple[800], // Cor do botão de ação flutuante
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor:
              Colors.purple[800], // Cor do texto nos botões de texto
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.purple[800], // Cor da barra de aplicativo
      ),
    ),
    home: TaskListScreen(),
  ));
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> _taskList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
      ),
      body: _buildTaskList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _addNewTask();
        },
      ),
    );
  }

  Widget _buildTaskList() {
    return ListView.builder(
      itemCount: _taskList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(_taskList[index].title),
          leading: Checkbox(
            value: _taskList[index].isDone,
            onChanged: (value) {
              setState(() {
                _taskList[index].isDone = value!;
              });
            },
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _editTask(index);
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _deleteTask(index);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _addNewTask() async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        String newTaskTitle = '';

        return AlertDialog(
          title: Text('Nova Tarefa'),
          content: TextField(
            onChanged: (value) {
              newTaskTitle = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Salvar'),
              onPressed: () {
                setState(() {
                  _taskList.add(Task(title: newTaskTitle));
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _editTask(int index) async {
    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        String editedTaskTitle = _taskList[index].title;

        return AlertDialog(
          title: Text('Editar Tarefa'),
          content: TextField(
            onChanged: (value) {
              editedTaskTitle = value;
            },
            controller: TextEditingController(text: _taskList[index].title),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('Salvar'),
              onPressed: () {
                setState(() {
                  _taskList[index].title = editedTaskTitle;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteTask(int index) {
    setState(() {
      _taskList.removeAt(index);
    });
  }
}
