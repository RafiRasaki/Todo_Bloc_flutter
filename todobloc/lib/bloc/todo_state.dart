part of 'todo_bloc.dart';

@immutable
sealed class TodoState {
  final List<Todo> todos;

  const TodoState(this.todos);
}

final class TodoInitial extends TodoState {
  const TodoInitial(super.todos);
}

//Menambahkan Data
final class TodoAdded extends TodoState{
  const TodoAdded(super.todos);

}
//Menghapus Data
final class TodoRemove extends TodoState{
  const TodoRemove(super.todos);
}

//Mengupdate Data
final class TodoUpdate extends TodoState{
  const TodoUpdate(super.todos);
}

