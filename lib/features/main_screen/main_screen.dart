import 'package:flutter/material.dart';
import 'package:qrone/features/companies/presentation/pages/companies_screen.dart';
import 'package:qrone/features/product/presentation/pages/get_products_screen.dart';
import 'package:qrone/features/product_types/presentation/pages/product_type_screen.dart';
import 'package:qrone/features/sync/presentation/pages/sync_screen.dart';
import 'package:qrone/features/units/presentation/pages/units_screen.dart';
import 'package:qrone/utils/extensions/buildcontextExtension.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SizedBox(
        width: context.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(context.width / 50),
                child: Text(
                  "Welcome To Your Shop",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: context.width * 0.1),
                ),
              ),
              SizedBox(
                height: context.height / 50,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width / 30),
                child: SizedBox(
                  width: context.width,
                  height: context.height / 1.2,
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: context.width / 20,
                        crossAxisSpacing: context.width / 20,
                        mainAxisExtent: context.height / 7),
                    children: [
                      MainButtons(
                        icon: Icons.shopping_cart_outlined,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) => GetProductsScreen()));
                        },
                        text: "Products",
                        color: Colors.blue.shade100,
                      ),
                      MainButtons(
                        icon: Icons.type_specimen_outlined,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) => ProductTypeScreen()));
                        },
                        text: "Product Types",
                        color: Colors.blue.shade200,
                      ),
                      MainButtons(
                        icon: Icons.signal_cellular_0_bar_outlined,
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (c) => UnitsScreen()));
                        },
                        text: "Units",
                        color: Colors.blue.shade300,
                      ),
                      MainButtons(
                        icon: Icons.account_balance_outlined,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) => CompanyScreen()));
                        },
                        text: "Companies",
                        color: Colors.blue.shade200,
                      ),
                      MainButtons(
                        icon: Icons.sync_outlined,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (c) => const SyncScreen()));
                        },
                        text: "Sync",
                        color: Colors.blue.shade100,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class MainButtons extends StatelessWidget {
  const MainButtons({
    super.key,
    required this.onTap,
    required this.text,
    required this.color,
    required this.icon,
  });
  final VoidCallback onTap;
  final Color color;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            width: context.width / 3.5,
            height: context.height / 7,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: color),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: context.height / 90),
                  child: Row(
                    children: [
                      SizedBox(
                        width: context.width / 30,
                      ),
                      Text(
                        text,
                        style: TextStyle(
                            fontSize: context.width * 0.05,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: context.height / 90),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        icon,
                        size: context.width / 12,
                      ),
                      SizedBox(
                        width: context.width / 50,
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}
