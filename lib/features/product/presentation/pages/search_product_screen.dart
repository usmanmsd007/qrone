import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrone/features/product/presentation/bloc_search/search_product_bloc.dart';
import 'package:qrone/features/product/presentation/widgets/product_widget.dart';

class SearchProductScreen extends StatelessWidget {
  const SearchProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close)),
      ),
      body: BlocConsumer<SearchProductBloc, SearchProductState>(
          builder: (c, s) {
            if (s is SearchProductLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (s is SearchProductErrorState) {
              return Center(
                child: Text(s.message),
              );
            }
            if (s is SearchProductSuccessState) {
              return ListView.builder(
                  itemCount: s.result.length,
                  itemBuilder: (c, i) => ProductWidget(product: s.result[i]));
            }
            return Container();
          },
          listener: (c, s) {}),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
              onPressed: () async {
                var result = await FlutterBarcodeScanner.scanBarcode(
                    '#ff6666', 'Cancel', true, ScanMode.BARCODE);
                context
                    .read<SearchProductBloc>()
                    .add(SearchByBarCode(barCode: result));
              },
              child: Text("Search Another")),
          // ElevatedButton(onPressed: (){}, child: Text("")),
        ],
      ),
    ));
  }
}
