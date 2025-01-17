import 'package:taskee/domain/datasources/datasources.dart';
import 'package:taskee/domain/helpers/failures/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:taskee/domain/helpers/failures/failures.dart';
import 'package:taskee/domain/usecases/usecases.dart';
import 'package:taskee/data/helpers/exceptions/exceptions.dart';

class AddTaskUsecase implements IAddTaskUsecase {
  final IAddTaskDatasource datasource;
  AddTaskUsecase(this.datasource);

  @override
  Future<Either<Failure, String>> addTask(
      String title, String subtitle, String state) async {
    try {
      final result = await datasource.addTask(title, subtitle, state);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
