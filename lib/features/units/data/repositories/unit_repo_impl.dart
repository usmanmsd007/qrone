import 'package:dartz/dartz.dart';
import 'package:qrone/core/errors.dart';
import 'package:qrone/core/exceptions.dart';
import 'package:qrone/features/units/data/datasources/unit_local_datasource.dart';
import 'package:qrone/features/units/data/models/units_model.dart';
import 'package:qrone/features/units/domain/entities/unit.dart';
import 'package:qrone/features/units/domain/repositories/unit_repository.dart';

typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class UnitRepositoryImplem implements UnitRepository {
  // UnitRemoteDataSource remoteDataSourcel;
  UnitLocalDataSource localDataSourcel;

  // NetworkInfo networkInfo;
  UnitRepositoryImplem({
    required this.localDataSourcel,
    // required this.remoteDataSourcel,

    // required this.networkInfo,
  });

  // @override
  // Future<Either<Failure, List<PostEntity>>> getAllPosts() async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       final remotePosts = await remoteDataSourcel.getAllPosts();
  //       localeDataSource.cashePosts(remotePosts);
  //       return Right(remotePosts);
  //     } on ServerFailure {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     try {
  //       final localPosts = await localeDataSource.getCachedPosts();
  //       return Right(localPosts);
  //     } on EmptyCacheFailure {
  //       return Left(EmptyCacheFailure());
  //     }
  //   }
  // }

  // @override
  // Future<Either<Failure, Unit>> addPost(
  //     {required PostEntity postEntity}) async {
  //   PostsModel postsModel = PostsModel(
  //       id: postEntity.id, title: postEntity.title, body: postEntity.body);
  //   return await getMessage(() {
  //     return remoteDataSourcel.addPost(postsModel);
  //   });
  // }

  // @override
  // Future<Either<Failure, Unit>> updatePost(
  //     {required PostEntity postEntity}) async {
  //   PostsModel postsModel = PostsModel(
  //       id: postEntity.id, title: postEntity.title, body: postEntity.title);
  //   return await getMessage(() {
  //     return remoteDataSourcel.updatePost(postsModel);
  //   });
  // }

  // @override
  // Future<Either<Failure, Unit>> deletePost({required int postId}) async {
  //   return await getMessage(() {
  //     return remoteDataSourcel.deletePost(postId);
  //   });
  // }

  // Future<Either<Failure, Unit>> getMessage(
  //     DeleteOrUpdateOrAddPost addOrUpdateOrDeleteFunction) async {
  //   if (await networkInfo.isConnected) {
  //     try {
  //       await addOrUpdateOrDeleteFunction();
  //       return const Right(unit);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     return Left(OffLineFailure());
  //   }
  // }

  @override
  Future<Either<Failure, Units>> addUnit(Units unit) async {
    try {
      var id =
          await localDataSourcel.insertTodatabase(UnitModel(unit: unit.unit));
      return Right(unit.copyWith(id: id));
    } on InsertException {
      return Left(InsertDataFailure());
    }
  }

  @override
  Future<Either<Failure, List<Units>>> getUnits() async {
    try {
      var units = await localDataSourcel.getUnitsModels();
      return Right(units);
    } on EmptyListException {
      return Left(EmptyListFailure());
    } on OtherListException {
      return Left(OtherListFailure());
    }
  }

  @override
  Future<Either<Failure, Units>> updateUnit(Units unit) async {
    try {
      var id = await localDataSourcel.updateUnit(UnitModel(unit: unit.unit));
      return Right(unit.copyWith(id: id));
    } on UpdateException {
      return Left(UpdateDataFailure());
    }
  }
}
