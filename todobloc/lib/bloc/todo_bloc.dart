import 'dart:async';
import 'package:d_method/d_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/Todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const TodoState([], TodoStatus.init)) {

    //Refector Event AddTodo
    on<OnAddTodo>(addTodo);

    //Refector Event UpdateTodo
    on<OnUpdateTodo>(updateTodo);

    //Refector Event RemoveTodo
    on<OnRemoveTodo>(removeTodo);

    //Refector Event FetchTodo
    on<OnFetchTodo>(fetchTodo);
  }

  FutureOr<void> fetchTodo(OnFetchTodo event, Emitter <TodoState>emit) async {
  emit (TodoState(state.todos, TodoStatus.loading));
  await Future.delayed(Duration(milliseconds: 1500));
  emit (TodoState([Todo('title', 'description')], TodoStatus.success));
  }

  FutureOr<void> removeTodo(OnRemoveTodo event, Emitter<TodoState> emit) async{
    int index = event.index;
    List<Todo> todosRemove = state.todos;
    todosRemove.removeAt(index);
    emit(TodoState(todosRemove, TodoStatus.success));
  }

  FutureOr<void> updateTodo(OnUpdateTodo event, Emitter<TodoState> emit)async {
    Todo newTodo = event.newTodo;
    int index = event.index;
    List<Todo> TodosUpdate = state.todos;
    TodosUpdate[index] = newTodo;
    emit(TodoState(TodosUpdate, TodoStatus.success));
  }

  FutureOr<void> addTodo(OnAddTodo event, Emitter<TodoState>emit) async {
    Todo newTodo = event.newTodo;
    emit(TodoState([...state.todos, newTodo], TodoStatus.success));
  }

  //Mencoba Observer
  @override
  void onChange(Change<TodoState> change) {
   /* DMethod.logTitle(
      change.currentState.status.toString(), 
      change.nextState.status.toString(),
    );*/
    super.onChange(change);
  }

  @override
  void onEvent(TodoEvent event) {
    //DMethod.log(event.toString()); 
    super.onEvent(event);
  }

  @override
  void onTransition(Transition<TodoEvent, TodoState> transition) {
    DMethod.log(transition.toString());
    super.onTransition(transition);
  }
}
