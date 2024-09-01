part of 'product_form_cubit.dart';

abstract class ProductFormState extends Equatable {
  const ProductFormState();

  @override
  List<Object> get props => [];
}

class ProductFormInProgress extends ProductFormState {
  const ProductFormInProgress();
}

class ProductFormReady extends ProductFormState {
  const ProductFormReady(this.productViewModel);

  final ProductViewModel productViewModel;

  @override
  List<Object> get props => [productViewModel];

  bool get isFormValid => productViewModel.title.isValid && productViewModel.price.isValid && !productViewModel.type.isUnknown;
}

class ProductFormSavingInProgress extends ProductFormReady {
  const ProductFormSavingInProgress(ProductViewModel productViewModel) : super(productViewModel);
}

class ProductFormEnded extends ProductFormReady {
  const ProductFormEnded(ProductViewModel productViewModel) : super(productViewModel);
}
