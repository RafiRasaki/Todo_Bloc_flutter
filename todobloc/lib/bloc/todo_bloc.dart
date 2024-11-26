import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/Todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoInitial([])) {

    //Refector Event AddTodo
    on<OnAddTodo>(addTodo);

    //Refector Event UpdateTodo
    on<OnUpdateTodo>(updateTodo);

    //Refector Event RemoveTodo
    on<OnRemoveTodo>(removeTodo);
  }

  FutureOr<void> removeTodo(OnRemoveTodo event, Emitter<TodoState> emit) async{
    emit (TodoLoading(state.todos));
    await Future.delayed(Duration(milliseconds: 1500));
    int index = event.index;
    List<Todo> todosRemove = state.todos;
    todosRemove.removeAt(index);
    emit(TodoRemove(todosRemove));
  }

  FutureOr<void> updateTodo(OnUpdateTodo event, Emitter<TodoState> emit)async {
    emit (TodoLoading(state.todos));
    await Future.delayed(Duration(milliseconds: 1500));
    Todo newTodo = event.newTodo;
    int index = event.index;
    List<Todo> TodosUpdate = state.todos;
    TodosUpdate[index] = newTodo;
    emit(TodoUpdate(TodosUpdate));
  }

  FutureOr<void> addTodo(OnAddTodo event, Emitter<TodoState>emit) async {
    emit (TodoLoading(state.todos));
    await Future.delayed(Duration(milliseconds: 1500));
    Todo newTodo = event.newTodo;
    emit(TodoAdded([...state.todos, newTodo]));
  }
}
