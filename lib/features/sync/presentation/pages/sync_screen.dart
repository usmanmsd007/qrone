import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrone/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:qrone/utils/extensions/buildcontextExtension.dart';

class SyncScreen extends StatelessWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BlocConsumer<SyncBloc, SyncState>(
            listener: (a, b) {
              if (b is SyncSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(b.message),
                  duration: const Duration(milliseconds: 1200),
                ));
              }
            },
            builder: (context, state) {
              if (state is SyncErrorState) {
                return Center(child: Text(state.m));
              }
              if (state is SyncLoadingState) {
                return Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text(state.message)
                    ],
                  ),
                );
              }
              if (state is NoInternetState) {
                return Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.width / 50),
                        child: const Text(
                            "Sorry! You don't have internet at the moment. Please try again"),
                      ),
                      SizedBox(
                        height: context.height / 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            context.read<SyncBloc>().add(UploadDataEvent());
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white30,
                              side: const BorderSide(color: Colors.black)),
                          child: const Text(
                            "Try Again",
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  ),
                );
              }

              if (state is SyncSuccess) {
                return Center(child: Text(state.message));
              }
              return GestureDetector(
                  onTap: () {
                    context.read<SyncBloc>().add(UploadDataEvent());
                  },
                  child: Center(child: Text("Initial state")));
            },
          )
        ],
      ),
    ));
  }
}
