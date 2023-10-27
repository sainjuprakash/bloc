import 'package:bloc_proj/cubit/counter_cubit.dart';
import 'package:bloc_proj/cubit/internet_cubit.dart';
import 'package:bloc_proj/presentation/Screens/HomePage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp(
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final Connectivity connectivity;
  const MyApp({super.key, required this.connectivity});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
            create: (context) => InternetCubit(connectivity: connectivity)),
       // BlocProvider<CounterCubit>(create: (context)=> CounterCubit(internetCubit: context.bloc<InternetCubit>)),
        BlocProvider<CounterCubit>(
            create: (context) => CounterCubit(
                internetCubit: InternetCubit(connectivity: connectivity))),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             BlocConsumer<CounterCubit, CounterState>(
//               builder: (context, state) {
//                 if (state.counterValue < 0) {
//                   return Text(
//                     'Negative' + state.counterValue.toString(),
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   );
//                 } else if (state.counterValue % 2 != 0) {
//                   return Text(
//                     'odd' + state.counterValue.toString(),
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   );
//                 }
//                 return Text(
//                   state.counterValue.toString(),
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 );
//               },
//               listener: (BuildContext context, CounterState state) {
//                 if (state.wasIncremented == true) {
//                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                     content: Text('Incremented'),
//                     duration: Duration(),
//                   ));
//                 } else if (state.wasIncremented == false) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                       const SnackBar(content: Text('Decremented')));
//                 }
//               },
//             ),
//             FloatingActionButton(
//               onPressed: () {
//                 BlocProvider.of<CounterCubit>(context).decrement();
//                 //context.bloc<CounterCubit>().decreme
//               },
//               tooltip: 'Decrement',
//               child: Icon(Icons.remove),
//             ),
//             FloatingActionButton(
//               onPressed: () {
//                 BlocProvider.of<CounterCubit>(context).increment();
//               },
//               tooltip: 'Decrement',
//               child: Icon(Icons.add),
//             ),
//           ],
//         ),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
