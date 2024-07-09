import 'package:flutter/material.dart';
import 'package:hive_cashe_storge_bloc/core/model/product_model.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

class SuccessGetProduct extends ProductState {
  final ListOf<ProductModel> productModels;
  SuccessGetProduct({required this.productModels});
}

class Storage extends ProductState {
  final ListOf<ProductModel> productModelsStorage;
  Storage({required this.productModelsStorage});
}

class LoadingGetProduct extends ProductState {}

class ErrorProducts extends ProductState {}
