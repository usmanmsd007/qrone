import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrone/features/companies/domain/entities/company_entity.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/product/presentation/bloc_product/product_bloc.dart'
    as pb;
import 'package:qrone/features/product/presentation/bloc_update_product/update_product_bloc.dart';
import 'package:qrone/features/product/presentation/widgets/my_textformfield.dart';
import 'package:qrone/features/product_types/domain/entities/product_type_entity.dart';
import 'package:qrone/features/units/domain/entities/unit.dart';
import 'package:qrone/utils/constants/globalKeys.dart';
import 'package:qrone/utils/extensions/buildcontextExtension.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen(
      {super.key,
      required this.companies,
      required this.productTypes,
      required this.units});
  final List<CompanyEntity> companies;
  final List<ProductTypeEntity> productTypes;
  final List<Units> units;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  late UpdateProductBloc b;
  late pb.ProductBloc productBloc;

  @override
  void initState() {
    super.initState();
    b = context.read<UpdateProductBloc>();
    productBloc = context.read<pb.ProductBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<UpdateProductBloc, UpdateProductState>(
            listener: (c, state) {
          if (state is UpdateProductSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Product has been Updated successfully")));
            productBloc.add(pb.GetProductsEvent());
            Navigator.pop(context);
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          return state is UpdateProductInitial
              ? SingleChildScrollView(
                  child: Form(
                    key: createProductKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: context.height / 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: () async {
                                  var result =
                                      await FlutterBarcodeScanner.scanBarcode(
                                          '#ff6666',
                                          'Cancel',
                                          true,
                                          ScanMode.BARCODE);
                                  b.add(UpdateBarCodeEvent(code: result));
                                },
                                child: const Text(("Scan code")))
                          ],
                        ),
                        SizedBox(
                          height: context.height / 60,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "BarCode:",
                              style: TextStyle(
                                  fontSize: context.width * 0.07,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: context.width / 40,
                            ),
                            Text(
                              state.barCode.toString(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: context.width * 0.07,
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: context.width / 12,
                            ),
                            GestureDetector(
                                onTap: () async {
                                  b.add(const UpdateBarCodeEvent(
                                    code: "",
                                  ));
                                },
                                child: Icon(
                                  Icons.restart_alt_sharp,
                                  size: context.width / 10,
                                )),
                          ],
                        ),
                        SizedBox(
                          height: context.height / 60,
                        ),
                        MyTextField(
                          hint: "Product Name",
                          icon: Icons.assignment_add,
                          ctrl: b.name,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter product name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: context.height / 40,
                        ),
                        MyTextField(
                          icon: Icons.onetwothree_rounded,
                          keyboard: TextInputType.number,
                          hint: "Product Price",
                          ctrl: b.price,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter price';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: context.height / 40,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<CompanyEntity>(
                            isExpanded: true,
                            hint: Text(
                              'Select Company',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: widget.companies
                                .map((CompanyEntity item) =>
                                    DropdownMenuItem<CompanyEntity>(
                                      value: item,
                                      child: Text(
                                        item.companyName,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: state.companyEntity,
                            onChanged: (value) {
                              b.add(UpdateCompanyIndexEvent(
                                  productTypeEntity: state.productTypeEntity,
                                  companyEnitity: value,
                                  unitEntity: state.unitEntity));
                            },
                            buttonStyleData: ButtonStyleData(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.width / 40),
                              height: context.height / 16,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              width: context.width / 1.3,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: context.height / 40,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<ProductTypeEntity>(
                            isExpanded: true,
                            hint: Text(
                              'Select Type',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: widget.productTypes
                                .map((ProductTypeEntity item) =>
                                    DropdownMenuItem<ProductTypeEntity>(
                                      value: item,
                                      child: Text(
                                        item.type,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: state.productTypeEntity,
                            onChanged: (ProductTypeEntity? value) {
                              b.add(UpdateCompanyIndexEvent(
                                productTypeEntity: value,
                                companyEnitity: state.companyEntity,
                                unitEntity: state.unitEntity,
                              ));
                            },
                            buttonStyleData: ButtonStyleData(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.width / 40),
                              height: context.height / 16,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              width: context.width / 1.3,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: context.height / 30,
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton2<Units>(
                            isExpanded: true,
                            hint: Text(
                              'Select Unit',
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                            items: widget.units
                                .map((Units item) => DropdownMenuItem<Units>(
                                      value: item,
                                      child: Text(
                                        item.unit,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            value: state.unitEntity,
                            onChanged: (Units? value) {
                              b.add(UpdateCompanyIndexEvent(
                                  productTypeEntity: state.productTypeEntity,
                                  companyEnitity: state.companyEntity,
                                  unitEntity: value));
                            },
                            buttonStyleData: ButtonStyleData(
                              padding: EdgeInsets.symmetric(
                                  horizontal: context.width / 40),
                              height: context.height / 16,
                              decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)),
                              width: context.width / 1.3,
                            ),
                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: context.height / 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (createProductKey.currentState!.validate()) {
                                print(b.name.text);
                                b.add(UpdateProductEvent(
                                    productEntity: ProductEntity(
                                        companyName: "",
                                        typeName: "",
                                        unitName: "",
                                        id: b.productId,
                                        productTypeId:
                                            state.productTypeEntity == null
                                                ? -1
                                                : state.productTypeEntity!.id,
                                        lastUpdated:
                                            DateTime.now().toIso8601String(),
                                        code: state.barCode,
                                        companyId: state.companyEntity == null
                                            ? -1
                                            : state.companyEntity!.id,
                                        name: b.name.text,
                                        price: double.parse(b.price.text),
                                        unitId: state.unitEntity!.id)));
                              }
                            },
                            child: const Text("Update Product")),
                        SizedBox(
                          height: context.height / 30,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Close"))
                      ],
                    ),
                  ),
                )
              : Container();
        }),
      ),
    );
  }
}
