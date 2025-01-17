import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:taskee/domain/entities/entities.dart';
import 'package:taskee/domain/helpers/helpers.dart';
import 'package:taskee/domain/usecases/usecases.dart';
import 'package:taskee/data/models/models.dart';
import 'package:taskee/ui/pages/toDo/todo_page.dart';

part 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final ILoginUsecase _loginUsecase;
  LoginController(this._loginUsecase) : super(LoginInitial());

  GetIt serviceLocator = GetIt.instance;

  String failureMessage = '';

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    final Either<Failure, UserEntity> result =
        await _loginUsecase.login(email, password);
    result.fold((failure) {
      emit(LoginError());
      failureMessage = failure.message;
    }, (right) {
      emit(LoginDone());

      serviceLocator.registerLazySingleton<UserModel>(() => UserModel(
            email: right.email,
            id: right.id,
            token: right.token,
          ));

      Get.toNamed(ToDoPage.route);
    });
  }
}
