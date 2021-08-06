import 'package:taskee/domain/helpers/failures/failure.dart';
import 'package:taskee/domain/entities/user_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:taskee/domain/helpers/failures/failures.dart';
import 'package:taskee/domain/repositories/repositories.dart';
import 'package:taskee/infra/datasources/datasources.dart';
import 'package:taskee/infra/helpers/helpers.dart';

class RegisterRepository implements IRegisterRepository {
  final IRegisterDatasource datasource;
  RegisterRepository(this.datasource);

  @override
  Future<Either<Failure, UserEntity>> register(
      String email, String password) async {
    try {
      final result = await datasource.register(email, password);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on AuthenticationException catch (error) {
      return Left(
        AuthenticationFailure(code: error.code, message: error.message),
      );
    }
  }
}