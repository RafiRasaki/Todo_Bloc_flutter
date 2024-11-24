part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

//Event Add
class OnAddTodo extends TodoEvent {
  final Todo newTodo;

  OnAddTodo(this.newTodo);
}

//Event Remove
class OnRemoveTodo extends TodoEvent {
  final int index;

  OnRemoveTodo(this.index);
}

//Event Update
class OnUpdateTodo extends TodoEvent {
  final int index;
  final Todo newTodo;

  OnUpdateTodo(this.index, this.newTodo);
}