import 'package:flutter/material.dart';
import 'package:qrone/features/product/domain/entities/product_entity.dart';
import 'package:qrone/features/product/presentation/widgets/product_widget.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({required this.product, super.key});
  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ProductWidget(product: product),
      ),
    );
  }
}
