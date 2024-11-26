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
            actionTitle: 'Tambahkan Todo',
          ),
         ]
       );
      }
    );
  }

  updateTodo(int index, Todo oldTodo){
    final edtTitle = TextEditingController();
    final edtDescription = TextEditingController();
    edtTitle.text = oldTodo.title;
    edtDescription.text = oldTodo.description;
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
              context.read<TodoBloc>().add(OnUpdateTodo(index,newTodo));
              Navigator.pop(context);
              DInfo.snackBarSuccess(
                context, 'Toda Berhasil Diupdate'
              );
            }, 
            actionTitle: 'Update',
          ),
         ]
       );
      }
    );
  }

  removeTodo(int index){
    DInfo.dialogConfirmation(
      context, 
      'Hapus Todo', 
      'Apakah Anda Yakin Ingin Menghapus Todo Ini?'
    ).then((bool? yes) {
      if (yes ?? false){
        context.read<TodoBloc>().add(OnRemoveTodo(index));
        DInfo.snackBarSuccess(context, 'Toda Berhasil Dihapus');
      }
     }
   );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Center(
          child: const Text(
            'ToDoList Item',
            ),
        ),
        backgroundColor: Colors.blueAccent,
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
                  backgroundColor: Colors.blueAccent,
                ),
                title: Text(todo.title),
                subtitle: Text(todo.description),
                trailing: PopupMenuButton(
                  onSelected: (value){
                    switch (value) {
                      case 'update':
                        updateTodo(index, todo);
                        break;

                      case 'remove' :
                        removeTodo(index);
                      break;
                      
                      default:
                      DInfo.snackBarError(
                        context, 
                        'Invalid Menu');
                    }
                  },
                  itemBuilder: (context) => [
                   const PopupMenuItem(
                    value: 'update',
                    child: Text(
                      'Update'
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'remove',
                    child: Text(
                      'Remove'
                    ),
                  ),
                ]),
              );
            }
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTodo,
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
        ),
    );
  }
}