import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/Todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoInitial([])) {

    on<OnAddTodo>((event, emit) {
      Todo newTodo = event.newTodo;
      emit(TodoAdded([...state.todos, newTodo]));
    });

    on<OnUpdateTodo>((event, emit) {
      Todo newTodo = event.newTodo;
      int index = event.index;
      List<Todo> TodosUpdate = state.todos;
      TodosUpdate[index] = newTodo;
      emit(TodoRemove(TodosUpdate));
    });

    on<OnRemoveTodo>((event, emit) {
      int index = event.index;
      List<Todo> todosRemove = state.todos;
      todosRemove.removeAt(index);
      emit(TodoRemove(todosRemove));
    });
  }
}
