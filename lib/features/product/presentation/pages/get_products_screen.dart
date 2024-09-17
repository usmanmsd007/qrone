import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrone/features/product/presentation/bloc_search/search_product_bloc.dart';
import 'package:qrone/features/product/presentation/bloc_product/product_bloc.dart';
import 'package:qrone/features/product/presentation/pages/add_product_screen.dart';
import 'package:qrone/features/product/presentation/pages/product_screen.dart';
import 'package:qrone/features/product/presentation/pages/search_product_screen.dart';
import 'package:qrone/features/product/presentation/widgets/search_delegate.dart';
import 'package:qrone/utils/extensions/buildcontextExtension.dart';

class GetProductsScreen extends StatelessWidget {
  const GetProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios)),
        title: const Text("Products"),
        actions: [
          GestureDetector(
            onTap: () {
              showSearch(
                  context: context,
                  delegate:
                      SearchProductDelegate(bloc: context.read<ProductBloc>()));
            },
            child: const Icon(Icons.search),
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
              onPressed: () async {
                var result = await FlutterBarcodeScanner.scanBarcode(
                    '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                if (result.isNotEmpty) {
                  context
                      .read<SearchProductBloc>()
                      .add(SearchByBarCode(barCode: result));
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (c) => const SearchProductScreen()));
                }
              },
              child: const Text(("Scan code"))),
          ElevatedButton(
            onPressed: () {
              context.read<ProductBloc>().add(MoveToNextScreen());
            },
            child: const Text("Add Product"),
          ),
        ],
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        builder: (BuildContext context, ProductState state) {
          return state is ProductsLoadingState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state is ProductErrorState
                  ? Center(
                      child: Text(state.e),
                    )
                  : state is GetProductSuccessState
                      ? ListView.builder(
                          itemCount: state.products.length,
                          itemBuilder: (c, i) => Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.width / 100),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (c) => ProductScreen(
                                        product: state.products[i])));
                              },
                              child: Card(
                                color: Colors.blue[100],
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: context.height / 60,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: context.height / 80,
                                          left: context.width / 36,
                                          right: context.width / 36),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${state.products[i].name} ${state.products[i].unitName}",
                                            style: TextStyle(
                                                color: Colors.blue[900],
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    context.width * 0.055),
                                          ),
                                          Text(
                                            "Rs: ${state.products[i].price}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    context.width * 0.055),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: context.width / 36,
                                        right: context.width / 36,
                                        bottom: context.height / 80,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            state.products[i].companyName,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    context.width * 0.055),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container();
        },
        listener: (BuildContext context, ProductState state) {
          if (state is NextScreenState) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (c) => AddProductScreen(
                      productTypes: state.productTypes,
                      companies: state.companies,
                      units: state.units,
                    )));
          }
        },
      ),
    );
  }
}
