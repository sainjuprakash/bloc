import 'package:bloc_proj/Constants/enums.dart';
import 'package:bloc_proj/cubit/internet_cubit.dart';
import 'package:bloc_proj/cubit/internet_state.dart';
import 'package:bloc_proj/presentation/Screens/secondPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/counter_cubit.dart';
import '../../cubit/counter_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});
  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit,InternetState >
              (builder: (context,state){
                if(state is InternetConnected&&state.connectiontypes==Connectiontypes.Wifi){
                  return Text('Wifi');
                }
                else if(state is InternetConnected&&state.connectiontypes==Connectiontypes.Mobile){
                  return Text('data');
                }
                else if(state is InternDisconnected ){
                  return Text('Disconnected');
                }

            return CircularProgressIndicator();
            },),
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            BlocConsumer<CounterCubit, CounterState>(
              builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text(
                    'Negative' + state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else if (state.counterValue % 2 != 0) {
                  return Text(
                    'odd' + state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
              listener: (BuildContext context, CounterState state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Incremented'),
                    duration: Duration(microseconds: 300),
                  ));
                } else if (state.wasIncremented == false) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Decremented'),
                    duration: Duration(microseconds: 300),
                  ));
                }
              },
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     FloatingActionButton(
            //       onPressed: () {
            //         BlocProvider.of<CounterCubit>(context).decrement();
            //         //context.bloc<CounterCubit>().decreme
            //       },
            //       tooltip: 'Decrement',
            //       child: Icon(Icons.remove),
            //     ),
            //     FloatingActionButton(
            //       onPressed: () {
            //         BlocProvider.of<CounterCubit>(context).increment();
            //       },
            //       tooltip: 'Decrement',
            //       child: Icon(Icons.add),
            //     ),
            //     SizedBox(
            //       height: 30,
            //     ),
            //   ],
            // ),
            MaterialButton(
                child: Text('Go to Secondscreen'),
                color: Colors.red,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                          value: BlocProvider.of<CounterCubit>(context),
                          child: const SecondScreen(title: 'Second Screen'))));
                })
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
