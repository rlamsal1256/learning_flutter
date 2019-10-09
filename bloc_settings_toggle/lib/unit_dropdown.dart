import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

/********* Event *************/

abstract class DropdownEvent extends Equatable {}

class DropdownChanged extends DropdownEvent {
  final String newValue;

  DropdownChanged({@required this.newValue}) : super();

  @override
  String toString() => "DropdownChanged { newValue: $newValue }";
}

/********* State *************/

class DropdownState extends Equatable {
  final String dropdownValue;

  DropdownState({@required this.dropdownValue})
      : assert(dropdownValue != null),
        super([dropdownValue]);
}

/********* Bloc *************/

class DropdownBloc extends Bloc<DropdownEvent, DropdownState> {
  @override
  DropdownState get initialState => DropdownState(dropdownValue: 'miles');

  @override
  Stream<DropdownState> mapEventToState(
    DropdownEvent event,
  ) async* {
    if (event is DropdownChanged) {
      yield DropdownState(
        dropdownValue: event.newValue,
      );
    }
  }
}

class CarBloc extends Bloc<DropdownEvent, DropdownState> {
  @override
  DropdownState get initialState => DropdownState(dropdownValue: 'toyota');

  @override
  Stream<DropdownState> mapEventToState(
    DropdownEvent event,
  ) async* {
    if (event is DropdownChanged) {
      yield DropdownState(
        dropdownValue: event.newValue,
      );
    }
  }
}
