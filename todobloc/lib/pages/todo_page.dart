import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todobloc/bloc/todo_bloc.dart';
import 'package:todobloc/widget/simple_input.dart';
import 'package:d_info/d_info.dart';

import '../Models/Todo.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {

  addTodo(){
    final edtTitle = TextEditingController();
    final edtDescription = TextEditingController();
    showDialog(
      context: context, 
      builder: (context){
        return SimpleDialog(
          contentPadding: EdgeInsets.all(20),
          children: [
          SimpleInput(
            edtTitle: edtTitle, 
            edtDescription: edtDescription, 
            onTap: (){
              Todo newTodo = Todo(
                edtTitle.text, 
                edtDescription.text
              );
              context.read<TodoBloc>().add(OnAddTodo(newTodo));
              Navigator.pop(context);
              DInfo.snackBarSuccess(
                context, 'Toda Berhasil Ditambahkan'
              );
            }, 
            actionTitle: 'Add Todo',
          ),
         ]
       );
      }
    );
  }

  updateTodo(){}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDoList Item'),
      ),
      body: BlocBuilder<TodoBloc,TodoState>(
        builder: (context,state) {
          if(state is TodoInitial) return const SizedBox.shrink();
          List<Todo> list = state.todos;
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: ((context, index) {
              Todo todo = list[index];
              return ListTile(
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text(todo.title),
                subtitle: Text(todo.description),
              );
            }
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: const Icon(Icons.add),
        ),
    );
  }
}