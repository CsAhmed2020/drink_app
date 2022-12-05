import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/category/category_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  StreamSubscription? _categorySubscription;

  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryLoading()){
    on<LoadCategories>(_onLoadCategories);
    on<UpdateCategories>(_onUpdateCategories);
  }

  void _onLoadCategories(event,Emitter<CategoryState> emit){
    _categorySubscription?.cancel();
    _categorySubscription = _categoryRepository.getAllCategories()
        .listen((categories) => add(UpdateCategories(categories),
    ),
    );
  }

  void _onUpdateCategories(event,Emitter<CategoryState> emit){
    emit(CategoryLoaded(categories: event.categories));
  }

}