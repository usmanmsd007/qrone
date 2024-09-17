import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrone/features/companies/domain/entities/company_entity.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/product/presentation/bloc_product/product_bloc.dart';
import 'package:qrone/features/product/presentation/bloc_update_product/update_product_bloc.dart';
import 'package:qrone/features/product/presentation/pages/update_product.dart';
import 'package:qrone/features/product_types/domain/entities/product_type_entity.dart';
import 'package:qrone/features/units/domain/entities/unit.dart';
import 'package:qrone/utils/extensions/buildcontextExtension.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({
    super.key,
    required this.product,
  });

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    UpdateProductBloc updateProductBloc = context.read<UpdateProductBloc>();
    ProductBloc productBloc = context.read<ProductBloc>();

    return Padding(
      padding: EdgeInsets.all(context.height / 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              updateProductBloc.add(SetInitialTextEvent(
                  id: product.id, name: product.name, price: product.price));
              // updateProductBloc.add(UpdateCompanyIndexEvent(
              //     companyEnitity: CompanyEntity(
              //         companyName: product.companyName, id: product.companyId),
              //     unitEntity: Units(unit: product.unitName, id: product.unitId),
              //     productTypeEntity: ProductTypeEntity(
              //         type: product.typeName, id: product.productTypeId)));
              updateProductBloc.add(UpdateBarCodeEvent(code: product.code));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => UpdateProductScreen(
                          companies: productBloc.companies,
                          productTypes: productBloc.productTypes,
                          units: productBloc.units)));
            },
            child: const Icon(Icons.edit),
          ),
          SizedBox(
            height: context.height / 60,
          ),
          const Text("Name: "),
          Text(
            product.name,
            style: TextStyle(
                fontSize: context.width * 0.07, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: context.height / 100,
          ),
          const Text("Price: "),
          Text(
            product.price.toString(),
            style: TextStyle(
                fontSize: context.width * 0.07, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: context.height / 100,
          ),
          const Text("Type: "),
          Text(
            product.typeName,
            style: TextStyle(
                fontSize: context.width * 0.07, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: context.height / 100,
          ),
          const Text("Company: "),
          Text(
            product.companyName,
            style: TextStyle(
                fontSize: context.width * 0.07, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: context.height / 100,
          ),
          const Text("Unit: "),
          Text(
            product.unitName,
            style: TextStyle(
                fontSize: context.width * 0.07, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: context.height / 100,
          ),
          const Text("Barcode: "),
          Text(
            product.code,
            style: TextStyle(
                fontSize: context.width * 0.07, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: context.height / 100,
          ),
          const Text("Last Updated: "),
          Text(
            product.lastUpdated,
            style: TextStyle(
                fontSize: context.width * 0.07, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
