import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qrone/features/companies/presentation/bloc/companies_bloc.dart';
import 'package:qrone/features/main_screen/main_screen.dart';
import 'package:qrone/features/product/presentation/bloc_search/search_product_bloc.dart';
import 'package:qrone/features/product/presentation/bloc_add_product/add_products_bloc.dart';
import 'package:qrone/features/product/presentation/bloc_product/product_bloc.dart';
import 'package:qrone/features/product/presentation/bloc_update_product/update_product_bloc.dart';
import 'package:qrone/features/product_types/presentation/bloc/product_type_bloc.dart';
import 'package:qrone/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:qrone/features/units/presentation/bloc/units_bloc.dart';
import 'package:qrone/firebase_options.dart';
import 'package:qrone/init_dependencies.dart';
import 'package:qrone/utils/constants/database_constants.dart';
import 'package:qrone/utils/resources/bloc_observer.dart';
import 'package:sqflite/sqflite.dart';

_onConfigure(Database db) async {
  // Add support for cascade delete
  await db.execute("PRAGMA foreign_keys = ON");
}

Future<Database> getDatabase() async {
  var databasesPath = await getDatabasesPath();
  String path = databasesPath + 'zaiiqa.db';
  final db = await openDatabase(path, version: 1, onConfigure: _onConfigure,
      onCreate: (Database d, int version) async {
    await d.execute(
        'CREATE TABLE  ${Dbc.UNITS}(${Dbc.ID} INTEGER PRIMARY KEY AUTOINCREMENT, ${Dbc.UNIT_NAME} TEXT)');

    await d.execute(
        'CREATE TABLE  ${Dbc.COMPANIES}(${Dbc.ID} INTEGER PRIMARY KEY AUTOINCREMENT, ${Dbc.COMPANYNAME} TEXT)');
    await d.execute(
        'CREATE TABLE  ${Dbc.PRODUCTTYPES}(${Dbc.ID} INTEGER PRIMARY KEY AUTOINCREMENT, ${Dbc.PRODUCTTYPE} TEXT)');
    await d.execute(
        '''CREATE TABLE ${Dbc.PRODUCT}(${Dbc.ID} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${Dbc.P_NAME} TEXT,
         ${Dbc.P_PRICE} DOUBLE,
        ${Dbc.P_CODE} TEXT,
        ${Dbc.PRODUCT_TYPE_ID} INT,
        ${Dbc.P_LASTUPDATED}  TEXT,
         ${Dbc.IS_SYNCED} INT,
         ${Dbc.P_ISDELETED_ID} INT,
        ${Dbc.P_COMPANY_ID} INT,
        ${Dbc.P_UNIT_ID} INT,
        FOREIGN KEY (${Dbc.P_COMPANY_ID}) REFERENCES ${Dbc.COMPANIES} (${Dbc.ID}),
        FOREIGN KEY (${Dbc.P_UNIT_ID}) REFERENCES ${Dbc.UNITS} (${Dbc.ID}),
        FOREIGN KEY (${Dbc.PRODUCT_TYPE_ID}) REFERENCES ${Dbc.PRODUCTTYPES} (${Dbc.ID})
        )''');
  });

  return db;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  init();
  Bloc.observer = AppBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<UnitsBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<UpdateProductBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SearchProductBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ProductBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<CompanyBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<AddProductsBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<ProductTypeBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SyncBloc>(),
        ),
      ],
      child: MaterialApp(
          home: const InitialScreen(),
          theme: ThemeData(
              appBarTheme: const AppBarTheme(foregroundColor: Colors.white),
              elevatedButtonTheme: const ElevatedButtonThemeData(
                  style: ButtonStyle(
                      side: WidgetStatePropertyAll<BorderSide>(
                          BorderSide(color: Colors.blue)),
                      foregroundColor:
                          WidgetStatePropertyAll<Color>(Colors.blue),
                      backgroundColor:
                          WidgetStatePropertyAll<Color>(Colors.white60))))),
    );
  }
}
