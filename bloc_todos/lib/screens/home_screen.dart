import 'package:flutter/material.dart';
import 'package:todos_app_core/todos_app_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/blocs/blocs.dart';
import 'package:flutter_todos/widgets/widgets.dart';
import 'package:flutter_todos/localization.dart';
import 'package:flutter_todos/models/models.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final tabBloc = BlocProvider.of<TabBloc>(context);
    // return BlocBuilder<TabBloc, AppTab>(
    //   builder: (context, activeTab) {
    return Scaffold(
      appBar: AppBar(
        title: Text(FlutterBlocLocalizations.of(context).appTitle),
        actions: [
          // FilterButton(visible: activeTab == AppTab.todos),
          FilterButton(visible: true),
          ExtraActions(),
        ],
      ),
      // body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
      body: FilteredTodos(),
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.addTodoFab,
        onPressed: () {
          Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
        },
        child: Icon(Icons.add),
        tooltip: ArchSampleLocalizations.of(context).addTodo,
      ),
      // bottomNavigationBar: TabSelector(
      //   activeTab: activeTab,
      //   onTabSelected: (tab) => tabBloc.dispatch(UpdateTab(tab)),
      // ),
    );
    // },
    // );
  }
}
