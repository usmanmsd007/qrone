import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:qrone/core/network/network_file.dart';
import 'package:qrone/features/companies/data/datasources/company_local_datasource.dart';
import 'package:qrone/features/companies/data/repositories/company_repo_impl.dart';
import 'package:qrone/features/companies/domain/repositories/company_repository.dart';
import 'package:qrone/features/companies/domain/usecases/get_company_usecase.dart';
import 'package:qrone/features/companies/domain/usecases/insert_company_usecase.dart';
import 'package:qrone/features/companies/presentation/bloc/companies_bloc.dart';
import 'package:qrone/features/product/data/datasources/product_local_data_source.dart';
import 'package:qrone/features/product/data/repositories/product_repo_impl.dart';
import 'package:qrone/features/product/domain/repositories/product_repo.dart';
import 'package:qrone/features/product/domain/usecases/add_product_usecase.dart';
import 'package:qrone/features/product/domain/usecases/get_products_usecase.dart';
import 'package:qrone/features/product/domain/usecases/search_product_usecase.dart';
import 'package:qrone/features/product/domain/usecases/update_product.dart';
import 'package:qrone/features/product/presentation/bloc_search/search_product_bloc.dart';
import 'package:qrone/features/product/presentation/bloc_add_product/add_products_bloc.dart';
import 'package:qrone/features/product/presentation/bloc_product/product_bloc.dart';
import 'package:qrone/features/product/presentation/bloc_update_product/update_product_bloc.dart';
import 'package:qrone/features/product_types/data/datasources/product_type_local_datasource.dart';
import 'package:qrone/features/product_types/data/repositories/product_type_repo_impl.dart';
import 'package:qrone/features/product_types/domain/repositories/product_type_repository.dart';
import 'package:qrone/features/product_types/domain/usecases/get_product_type_usecase.dart';
import 'package:qrone/features/product_types/domain/usecases/insert_product_type_usecase.dart';
import 'package:qrone/features/product_types/presentation/bloc/product_type_bloc.dart';
import 'package:qrone/features/sync/data/datasources/sync_local_datasource.dart';
import 'package:qrone/features/sync/data/datasources/sync_remote_data_source.dart';
import 'package:qrone/features/sync/data/repositories/sync_repo_impl.dart';
import 'package:qrone/features/sync/domain/repositories/sync_repo.dart';
import 'package:qrone/features/sync/domain/usecases/get_un_synced_products_usecase.dart';
import 'package:qrone/features/sync/domain/usecases/upload_companies_usecase.dart';
import 'package:qrone/features/sync/domain/usecases/upload_product_types_usecase.dart';
import 'package:qrone/features/sync/domain/usecases/upload_product_usecase.dart';
import 'package:qrone/features/sync/domain/usecases/upload_unit_usecase.dart';
import 'package:qrone/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:qrone/features/units/data/datasources/unit_local_datasource.dart';
import 'package:qrone/features/units/data/repositories/unit_repo_impl.dart';
import 'package:qrone/features/units/domain/repositories/unit_repository.dart';
import 'package:qrone/features/units/domain/usecases/get_unit_usecase.dart';
import 'package:qrone/features/units/domain/usecases/insert_unit_usecase.dart';
import 'package:qrone/features/units/domain/usecases/update_unit_usecase.dart';
import 'package:qrone/features/units/presentation/bloc/units_bloc.dart';
import 'package:qrone/main.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  ///BLOCS

  sl.registerFactory<UnitsBloc>(() => UnitsBloc(
      getUnitUsecase: sl(), insertUnitUsecase: sl(), updateUnitUsecase: sl())
    ..add(GetUnitsEvent()));
  sl.registerFactory<SyncBloc>(() => SyncBloc(
      getCompanyUsecase: sl(),
      uploadCompaniesUsecase: sl(),
      uploadProductTypesUsecase: sl(),
      uploadUnitsUsecase: sl(),
      uploadProductsUsecase: sl(),
      getUnitUsecase: sl(),
      getProductTypeUsecase: sl(),
      getProductsUsecase: sl()));
  sl.registerFactory<ProductTypeBloc>(() => ProductTypeBloc(
      insertProductTypeUsecase: sl(), getProductTypeUsecase: sl())
    ..add(const GetProductTypeEvent()));
  sl.registerFactory<CompanyBloc>(() =>
      CompanyBloc(getCompanyUsecase: sl(), insertCompanyUsecase: sl())
        ..add(GetCompanyEvent()));
  sl.registerFactory<ProductBloc>(() => ProductBloc(
      getProducts: sl(),
      getCompanyUsecase: sl(),
      unitUsecase: sl(),
      getProductTypeUsecase: sl())
    ..add(GetProductsEvent()));
  sl.registerFactory<AddProductsBloc>(
    () => AddProductsBloc(
        getCompanyUsecase: sl(), unitUsecase: sl(), addProductsUsecase: sl()),
  );

  sl.registerFactory<UpdateProductBloc>(
    () => UpdateProductBloc(
        getCompanyUsecase: sl(), unitUsecase: sl(), updateProductUsecase: sl()),
  );
  sl.registerFactory<SearchProductBloc>(
    () => SearchProductBloc(searchProduct: sl()),
  );

  /// REPOSITORIES
  //Repositories

  sl.registerLazySingleton<ProductTypeRepository>(
      () => ProductTypeRepositoryImplem(
            localDataSourcel: sl(),
          ));

  sl.registerLazySingleton<SyncRepo>(() => SyncRepoImpl(
        syncLocalDataSource: sl(),
        networkInfo: sl(),
        syncRemoteDataSource: sl(),
      ));

  sl.registerLazySingleton<UnitRepository>(() => UnitRepositoryImplem(
        localDataSourcel: sl(),
      ));

  sl.registerLazySingleton<CompanyRepository>(() => CompanyRepositoryImplem(
        localDataSourcel: sl(),
      ));

  sl.registerLazySingleton<ProductRepo>(() => ProductRepoImpl(
        localDataSource: sl(),
      ));

  //UseCases
  sl.registerLazySingleton(() => InsertProductTypeUsecase(repo: sl()));
  sl.registerLazySingleton(() => UpdateProductUsecase(repo: sl()));
  sl.registerLazySingleton(() => GetProductTypeUsecase(repo: sl()));
  sl.registerLazySingleton(() => InsertUnitUsecase(repo: sl()));
  sl.registerLazySingleton(() => UpdateUnitUsecase(repo: sl()));
  sl.registerLazySingleton(() => GetUnitUsecase(repo: sl()));
  sl.registerLazySingleton(() => InsertCompanyUsecase(repo: sl()));
  sl.registerLazySingleton(() => GetCompanyUsecase(repo: sl()));
  sl.registerLazySingleton(() => AddProductsUsecase(repo: sl()));
  sl.registerLazySingleton(() => GetProductsUsecase(repo: sl()));
  sl.registerLazySingleton(() => SearchProductsUsecase(repo: sl()));
  sl.registerLazySingleton(() => UploadCompaniesUsecase(repo: sl()));
  sl.registerLazySingleton(() => UploadUnitsUsecase(repo: sl()));
  sl.registerLazySingleton(() => UploadProductTypesUsecase(repo: sl()));
  sl.registerLazySingleton(() => UploadProductsUsecase(repo: sl()));
  sl.registerLazySingleton(() => GetUnSyncedProductsUsecase(repo: sl()));

  //DataSource
  sl.registerLazySingleton<SyncRemoteDataSource>(
      () => SyncRemoteDataSourceImpl(firebaseFirestore: sl()));
  sl.registerLazySingleton<SyncLocalDataSource>(
      () => SyncLocalDatasourceImpl(db: sl()));
  sl.registerLazySingleton<UnitLocalDataSource>(
      () => LocaleDataSourceImplem(db: sl()));
  sl.registerLazySingleton<ProductTypeLocalDatasource>(
      () => ProductTypeLocalDatasourceImpl(db: sl()));

  sl.registerLazySingleton<CompanyLocalDataSource>(
      () => CompanyLocaleDataSourceImplem(db: sl()));
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(db: sl()));

// Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImplem());
  //database
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => firestore);
  final db = await getDatabase();
  sl.registerLazySingleton(
    () => db,
  );
}
