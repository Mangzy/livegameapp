import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesGameCubit extends Cubit<String> {
  CategoriesGameCubit() : super('Shooter');

  void selectCategory(String category) {
    emit(category);
  }
}
