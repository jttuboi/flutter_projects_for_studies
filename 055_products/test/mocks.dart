import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:products/domain/repositories/products_repository.dart';
import 'package:products/presentation/products/bloc/products_bloc.dart';

class MockProductsRepository extends Mock implements IProductsRepository {}

class MockProductsBloc extends MockBloc<ProductsEvent, ProductsState> implements ProductsBloc {}
