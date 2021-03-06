import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management/cubit/catBloc/cats_cubit.dart';
import 'package:state_management/cubit/catBloc/cats_state.dart';
import 'package:state_management/cubit/counter/counter_cubit.dart';

class BlocCatsView extends StatefulWidget {
  @override
  _BlocCatsViewState createState() => _BlocCatsViewState();
}

class _BlocCatsViewState extends State<BlocCatsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: buildBlocConsumer(),
      ),
    );
  }

  BlocConsumer<CatsCubit, CatsState> buildBlocConsumer() {
    return BlocConsumer<CatsCubit, CatsState>(
      listener: (context, state) {
        if (state is CatsError) {
          final snackBar = SnackBar(content: Text('Yay! A SnackBar!'));
          Scaffold.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        if (state is CatsInitial) {
          context.bloc<CounterCubit>().reset();
          return buildScaffoldInitial(context);
        } else if (state is CatsLoading) {
          return buildScaffoldLoading();
        } else if (state is CatsCompleted) {
          return buildScaffoldListView(state);
        } else {
          final error = state as CatsError;
          return buildScaffoldError(error);
        }
      },
    );
  }

  Scaffold buildScaffoldInitial(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.bloc<CatsCubit>().getCats();
        },
        child: Icon(Icons.get_app),
      ),
      body: buildCenterText(),
    );
  }

  Center buildCenterText() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("This is CatCubit"),
          BlocBuilder<CounterCubit, CounterState>(
            builder: (context, state) {
              return TextButton(
                onPressed: () {
                  context.bloc<CounterCubit>().increment();
                },
                child: Text(state.counter.toString()),
              );
            },
          ),
        ],
      ),
    );
  }

  Scaffold buildScaffoldLoading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Scaffold buildScaffoldError(CatsError error) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(error.message),
          ],
        ),
      ),
    );
  }

  Scaffold buildScaffoldListView(CatsCompleted state) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          title: Image.network(state.response[index].imageUrl),
          subtitle: Text(state.response[index].description),
        ),
        itemCount: state.response.length,
      ),
    );
  }
}
