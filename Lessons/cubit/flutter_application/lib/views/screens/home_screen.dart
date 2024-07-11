import 'package:flutter/material.dart';
import 'package:flutter_application/controllers/cubit_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _controller = context.read<CubitController>();
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                  onPressed: () {
                    _controller.increment();
                  },
                  icon: Icon(Icons.add)),
              IconButton(
                  onPressed: () {
                    _controller.decrement();
                  },
                  icon: Icon(Icons.remove))
            ],
          ),
        ),
        body: BlocBuilder(
            bloc: _controller,
            builder: (context, snapshot) {
              return Center(
                child: Text(_controller.state.toString()),
              );
            }));
  }
}
