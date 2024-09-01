import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:path/path.dart';

import 'package:products/domain/enums/product_type.dart';
import 'package:products/domain/repositories/products_repository.dart';
import 'package:products/domain/services/device_service.dart';
import 'package:products/presentation/product_form/view_models/product_view_model.dart';

part 'product_form_state.dart';

class ProductFormCubit extends Cubit<ProductFormState> {
  ProductFormCubit({required String productId, IProductsRepository? productsRepository, IDeviceService? deviceService})
      : super(const ProductFormInProgress()) {
    this.productsRepository = productsRepository ?? GetIt.I.get<IProductsRepository>();
    this.deviceService = deviceService ?? GetIt.I.get<IDeviceService>();

    formLoaded(productId);
  }

  late final IProductsRepository productsRepository;
  late final IDeviceService deviceService;

  Future<void> formLoaded(String productId) async {
    final product = await productsRepository.getProduct(productId);
    emit(ProductFormReady(ProductViewModel.fromProductModel(product)));
  }

  Future<void> formSubmitted() async {
    final productViewModelEdited = (state as ProductFormReady).productViewModel;
    emit(ProductFormSavingInProgress(productViewModelEdited));

    final product = await productsRepository.getProduct(productViewModelEdited.id);

    final newPicturePath =
        await _createPictureOnProductsDeviceFolder(product.filename, productViewModelEdited.picturePath);

    await productsRepository.updateProduct(product.copyWith(
      title: productViewModelEdited.title.value,
      type: productViewModelEdited.type,
      description: productViewModelEdited.description,
      price: productViewModelEdited.price.toDouble(),
      rating: productViewModelEdited.rating.toInt(),
      filename: basename(productViewModelEdited.picturePath),
      picturePath: newPicturePath,
    ));

    emit(ProductFormEnded(productViewModelEdited));
  }

  void pictureChanged(String picturePath) {
    final oldProductViewModel = (state as ProductFormReady).productViewModel;
    emit(ProductFormReady(oldProductViewModel.copyWith(picturePath: picturePath)));
  }

  void ratingChanged(double rating) {
    final oldProductViewModel = (state as ProductFormReady).productViewModel;
    emit(ProductFormReady(oldProductViewModel.copyWith(rating: rating)));
  }

  void titleChanged(String title) {
    final oldProductViewModel = (state as ProductFormReady).productViewModel;
    emit(ProductFormReady(oldProductViewModel.copyWith(title: oldProductViewModel.title.changing(title))));
  }

  void typeChanged(ProductType type) {
    final oldProductViewModel = (state as ProductFormReady).productViewModel;
    emit(ProductFormReady(oldProductViewModel.copyWith(type: type)));
  }

  void priceChanged(String price) {
    final oldProductViewModel = (state as ProductFormReady).productViewModel;
    emit(ProductFormReady(oldProductViewModel.copyWith(price: oldProductViewModel.price.changing(price))));
  }

  void descriptionChanged(String description) {
    final oldProductViewModel = (state as ProductFormReady).productViewModel;
    emit(ProductFormReady(oldProductViewModel.copyWith(description: description)));
  }

  void titleUnfocused() {
    final oldProductViewModel = (state as ProductFormReady).productViewModel;
    emit(ProductFormReady(oldProductViewModel.copyWith(title: oldProductViewModel.title.ready())));
  }

  void priceUnfocused() {
    final oldProductViewModel = (state as ProductFormReady).productViewModel;
    emit(ProductFormReady(oldProductViewModel.copyWith(price: oldProductViewModel.price.ready())));
  }

  Future<String> _createPictureOnProductsDeviceFolder(String productFilename, String picturePath) async {
    final newFilename = basename(picturePath);
    var newPicturePath = picturePath;
    if (newFilename != productFilename) {
      newPicturePath = await deviceService.createPictureOnProductsDeviceFolder(picturePath);
    }
    return newPicturePath;
  }
}
