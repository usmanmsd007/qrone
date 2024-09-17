import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/product/presentation/bloc_product/product_bloc.dart';

class SearchProductDelegate extends SearchDelegate<ProductEntity> {
  ProductBloc bloc;
  SearchProductDelegate({required this.bloc});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          bloc.add(CloseSearchBarEvent());
          Navigator.of(context).pop();
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isNotEmpty) {
      bloc.add(SearchProductKeywordEvent(keyWord: query));
    } else {
      bloc.add(SearchProductKeywordEvent(keyWord: ""));
    }
    return BlocBuilder<ProductBloc, ProductState>(builder: (c, state) {
      return state is SearchProductKeywordState
          ? Column(
              children: List.generate(
                  state.products.length,
                  (i) => ListTile(
                        title: Text(state.products[i].name),
                      )))
          : Text("Hello");
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isNotEmpty) {
      bloc.add(SearchProductKeywordEvent(keyWord: query));
    } else {
      bloc.add(SearchProductKeywordEvent(keyWord: ""));
    }
    return BlocBuilder<ProductBloc, ProductState>(builder: (c, state) {
      return state is SearchProductKeywordState
          ? Column(
              children: List.generate(
                  state.products.length,
                  (i) => ListTile(
                        title: Text(state.products[i].name),
                      )))
          : Text("Hello");
    });
  }
}
