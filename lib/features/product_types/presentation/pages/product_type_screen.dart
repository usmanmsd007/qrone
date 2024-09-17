import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrone/features/product/presentation/widgets/my_textformfield.dart';
import 'package:qrone/features/product_types/domain/entities/product_type_entity.dart';
import 'package:qrone/features/product_types/presentation/bloc/product_type_bloc.dart';
import 'package:qrone/features/units/presentation/bloc/units_bloc.dart';
import 'package:qrone/utils/extensions/buildcontextExtension.dart';

class ProductTypeScreen extends StatelessWidget {
  ProductTypeScreen({super.key});
  final TextEditingController typeCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Product Types"),
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
                                validator: (s) => "",
                                ctrl: typeCtrl,
                                hint: "Type",
                                icon: Icons.control_point_duplicate),
                            // child: TextFormField(
                            //   decoration: InputDecoration.collapsed(
                            //     hintText: "Type",
                            //     border: OutlineInputBorder(),
                            //     enabled: true,
                            //     fillColor: Colors.blue[50],
                            //   ),
                            //   controller: typeCtrl,
                            // )
                          ),
                          SizedBox(
                            height: context.height / 40,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                context
                                    .read<ProductTypeBloc>()
                                    .add(InsertProductTypeEvent(
                                        productType: ProductTypeEntity(
                                      type: typeCtrl.text,
                                    )));
                                Navigator.pop(context);
                              },
                              child: const Text("Add "))
                        ],
                      ),
                    ));
          },
          child: const Text("ADD")),
      body: BlocConsumer<ProductTypeBloc, ProductTypeState>(
        builder: (context, state) {
          return state is UnitLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is ProductTypeErrorState
                  ? Center(
                      child: Text(state.e),
                    )
                  : state is ProductTypeScueessState
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
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: context.width / 20,
                                                vertical: context.height / 80),
                                            child: Text(
                                              state.m[i].type,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      context.width * 0.06),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                        )
                      : Container();
        },
        listener: (BuildContext context, ProductTypeState state) {
          print(state.toString());
        },
      ),
    );
  }
}
