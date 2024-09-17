import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrone/features/companies/domain/entities/company_entity.dart';
import 'package:qrone/features/companies/presentation/bloc/companies_bloc.dart';
import 'package:qrone/features/product/presentation/widgets/my_textformfield.dart';
import 'package:qrone/utils/extensions/buildcontextExtension.dart';

class CompanyScreen extends StatelessWidget {
  CompanyScreen({super.key});
  final TextEditingController unitsCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("Companies"),
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
                                hint: "Company",
                                icon: Icons.border_all_rounded,
                              )),
                          SizedBox(
                            height: context.height / 40,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                context.read<CompanyBloc>().add(
                                    InsertCompanyEvent(
                                        unit: CompanyEntity(
                                            companyName: unitsCtrl.text)));
                                Navigator.pop(context);
                              },
                              child: Text("Add Company"))
                        ],
                      ),
                    ));
          },
          child: const Text("ADD")),
      body: BlocConsumer<CompanyBloc, CompanyState>(
        builder: (context, state) {
          return state is CompanyLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is CompanyErrorState
                  ? Center(
                      child: Text(state.e),
                    )
                  : state is CompanyScueessState
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.width / 50),
                          child: ListView.builder(
                              itemCount: state.companies.length,
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
                                              state.companies[i].companyName,
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
                      // ListView.builder(
                      //     itemCount: state.companies.length,
                      //     itemBuilder: (c, i) => ListTile(
                      //           tileColor: i % 2 == 0
                      //               ? Colors.orange
                      //               : Colors.pink.shade300,
                      //           title: Text(
                      //             state.companies[i].companyName,
                      //             style: TextStyle(color: Colors.black),
                      //           ),
                      //         ))
                      : Container();
        },
        listener: (BuildContext context, CompanyState state) {
          print(state.toString());
        },
      ),
    );
  }
}
