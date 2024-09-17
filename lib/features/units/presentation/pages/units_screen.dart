import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrone/features/product/presentation/widgets/my_textformfield.dart';
import 'package:qrone/features/units/domain/entities/unit.dart';
import 'package:qrone/features/units/presentation/bloc/units_bloc.dart';
import 'package:qrone/utils/extensions/buildcontextExtension.dart';

class UnitsScreen extends StatelessWidget {
  UnitsScreen({super.key});
  final TextEditingController unitsCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Units"),
      ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (c) => AlertDialog(
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: context.width / 1.3,
                              child: MyTextField(
                                ctrl: unitsCtrl,
                                validator: (String? _) => "",
                                hint: 'Unit',
                                icon: Icons.unfold_more_outlined,
                              )),
                          SizedBox(
                            height: context.height / 40,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                context.read<UnitsBloc>().add(InsertUnitEvent(
                                    unit: Units(unit: unitsCtrl.text)));
                                Navigator.pop(context);
                              },
                              child: Text("Add Unit"))
                        ],
                      ),
                    ));
          },
          child: Text("ADD")),
      body: BlocConsumer<UnitsBloc, UnitsState>(
        builder: (context, state) {
          return state is UnitLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is UnitErrorState
                  ? Center(
                      child: Text(state.e),
                    )
                  : state is UnitsSuccesssState
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.width / 50),
                          child: ListView.builder(
                              itemCount: state.m.length,
                              itemBuilder: (c, i) => Padding(
                                    padding: EdgeInsets.only(
                                        top: context.height / 90),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: i % 2 == 1
                                            ? Colors.blue[400]
                                            : Colors.blue[100],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: context.width / 20,
                                            vertical: context.height / 80),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              state.m[i].unit,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      context.width * 0.06),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (c) => AlertDialog(
                                                          title: Text(
                                                              "Delete Unit"),
                                                          content: Text(
                                                              "Do you want to delete this unit?"),
                                                          actions: [
                                                            GestureDetector(
                                                                onTap: () {
                                                                  context
                                                                      .read<
                                                                          UnitsBloc>()
                                                                      .add(DeleteUnitsEvent(
                                                                          unit:
                                                                              state.m[i]));
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                    "Yes")),
                                                            SizedBox(
                                                              width: context
                                                                      .width /
                                                                  40,
                                                            ),
                                                            GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Text("No")),
                                                          ],
                                                        ));
                                              },
                                              child: const Icon(Icons.delete),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                        )
                      //  ListView.builder(
                      //     itemCount: state.m.length,
                      //     itemBuilder: (c, i) => ListTile(
                      //           trailing: GestureDetector(
                      //             onTap: () {
                      //               showDialog(
                      //                   context: context,
                      //                   builder: (c) => AlertDialog(
                      //                         title: Text("Delete Unit"),
                      //                         content: Text(
                      //                             "Do you want to delete this unit?"),
                      //                         actions: [
                      //                           GestureDetector(
                      //                               onTap: () {
                      //                                 context
                      //                                     .read<UnitsBloc>()
                      //                                     .add(DeleteUnitsEvent(
                      //                                         unit:
                      //                                             state.m[i]));
                      //                                 Navigator.pop(context);
                      //                               },
                      //                               child: Text("Yes")),
                      //                           SizedBox(
                      //                             width: context.width / 40,
                      //                           ),
                      //                           GestureDetector(
                      //                               onTap: () {
                      //                                 Navigator.pop(context);
                      //                               },
                      //                               child: Text("No")),
                      //                         ],
                      //                       ));
                      //             },
                      //             child: const Icon(Icons.delete),
                      //           ),
                      //           title: Text(state.m[i].unit),
                      //         ))
                      : Container();
        },
        listener: (BuildContext context, UnitsState state) {
          if (state is UnitDeleteErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Sorry Could not delete unit at the moment. Please try again.")));
          }
          if (state is UnitsDeleteSuccesssState) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Unit deleted Successfully")));
          }
        },
      ),
    );
  }
}
