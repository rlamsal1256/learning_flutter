import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_settings_toggle/unit_dropdown.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<DropdownBloc>(
          builder: (context) => DropdownBloc(),
        ),
        BlocProvider<CarBloc>(
          builder: (context) => CarBloc(),
        ),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Settings',
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            BlocBuilder<DropdownBloc, DropdownState>(
              builder: (context, state) {
                final dropdownItems = <String>['miles', 'kilometers'];
                final value = state?.dropdownValue;
                final dropdownBloc = BlocProvider.of<DropdownBloc>(context);

                return Dropdown(
                  selectedValue: value,
                  items: dropdownItems,
                  bloc: dropdownBloc,
                );
              },
            ),
            BlocBuilder<CarBloc, DropdownState>(
              builder: (context, state) {
                final dropdownItems = <String>['toyota', 'honda'];
                final value = state?.dropdownValue;
                final carBloc = BlocProvider.of<CarBloc>(context);

                return Dropdown(
                  selectedValue: value,
                  items: dropdownItems,
                  bloc: carBloc,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Dropdown extends StatelessWidget {
  final String _value;
  final Bloc _bloc;
  final List<String> _items;
  static const Color grayPink = Color(0xFFFAF5F5);
  static const Color brightPink = Color(0xFFFF4F4F);

  Dropdown({
    @required String selectedValue,
    @required List<String> items,
    @required Bloc bloc,
  })  : _value = selectedValue,
        _bloc = bloc,
        _items = items;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: grayPink,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: grayPink,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              value: _value,
              icon: Icon(Icons.arrow_downward),
              iconEnabledColor: brightPink,
              iconSize: 25,
              elevation: 16,
              style: TextStyle(
                color: brightPink,
                fontWeight: FontWeight.w400,
              ),
              onChanged: (String newValue) {
                _bloc.dispatch(DropdownChanged(newValue: newValue));
              },
              items: _items.map<DropdownMenuItem<String>>(
                (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Center(
                      child: Text(value),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
