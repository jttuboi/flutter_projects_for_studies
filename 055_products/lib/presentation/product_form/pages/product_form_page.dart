// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:products/domain/enums/product_type.dart';
import 'package:products/domain/utils.dart';
import 'package:products/presentation/product_form/cubit/product_form_cubit.dart';
import 'package:products/presentation/product_form/view_models/product_view_model.dart';
import 'package:select_form_field/select_form_field.dart';

class ProductFormPage extends StatelessWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  static const routeName = '/product_form';

  static Route route(String productId) => MaterialPageRoute(builder: (context) {
        return BlocProvider(
          create: (context) => ProductFormCubit(productId: productId),
          child: const ProductFormPage(),
        );
      });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductFormCubit, ProductFormState>(
      listener: (context, state) {
        if (state is ProductFormEnded) {
          const durationInSeconds = 1;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Product updated.'),
            duration: Duration(seconds: durationInSeconds),
          ));
          Future.delayed(const Duration(seconds: durationInSeconds)).whenComplete(() {
            Navigator.pop(context);
          });
        }
      },
      builder: (context, state) {
        if (state is ProductFormInProgress) {
          return _buildProductFormInProgress();
        }

        if (state is ProductFormSavingInProgress) {
          return _buildProductFormSavingInProgress(state.productViewModel, context);
        }

        if (state is ProductFormEnded) {
          return _buildProductForm(state.productViewModel, state.isFormValid, context);
        }

        return _buildProductForm((state as ProductFormReady).productViewModel, state.isFormValid, context);
      },
    );
  }

  Widget _buildProductFormInProgress() {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit product')),
      body: const Center(child: CircularProgressIndicator.adaptive()),
    );
  }

  Widget _buildProductFormSavingInProgress(ProductViewModel productViewModel, BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit product'),
          actions: [
            IconButton(
              onPressed: null,
              tooltip: 'Save',
              icon: Icon(Icons.save_alt_rounded, color: Colors.deepPurple.shade400),
            )
          ],
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.deepPurple.shade400),
            onPressed: null,
          ),
        ),
        body: Stack(
          children: [
            ProductFormContent(productViewModel: productViewModel),
            Container(
              color: Colors.black.withOpacity(0.5),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            const Center(child: CircularProgressIndicator.adaptive()),
          ],
        ),
      ),
    );
  }

  Widget _buildProductForm(ProductViewModel productViewModel, bool canSubmit, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit product'),
        actions: [
          IconButton(
            onPressed: () {
              if (canSubmit) {
                context.read<ProductFormCubit>().formSubmitted();
              }
            },
            tooltip: 'Save',
            icon: Icon(
              Icons.save_alt_rounded,
              color: canSubmit ? Theme.of(context).primaryIconTheme.color : Colors.deepPurple.shade400,
            ),
          ),
        ],
      ),
      body: ProductFormContent(productViewModel: productViewModel),
    );
  }
}

class ProductFormContent extends StatefulWidget {
  const ProductFormContent({required this.productViewModel, Key? key}) : super(key: key);

  final ProductViewModel productViewModel;

  @override
  _ProductFormContentState createState() => _ProductFormContentState();
}

class _ProductFormContentState extends State<ProductFormContent> {
  final FocusNode _titleFocusNode = FocusNode();
  final FocusNode _typeFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _descriptionFocusNode = FocusNode();

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleFocusNode.addListener(() {
      if (!_titleFocusNode.hasFocus) {
        context.read<ProductFormCubit>().titleUnfocused();
      }
    });
    _priceFocusNode.addListener(() {
      if (!_priceFocusNode.hasFocus) {
        context.read<ProductFormCubit>().priceUnfocused();
      }
    });
  }

  @override
  void dispose() {
    _titleFocusNode.dispose();
    _typeFocusNode.dispose();
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              InkWell(
                onTap: () async {
                  final newPictureUploaded = await _picker.pickImage(source: ImageSource.gallery);
                  if (mounted && newPictureUploaded != null) {
                    context.read<ProductFormCubit>().pictureChanged(newPictureUploaded.path);
                  }
                },
                child: (widget.productViewModel.picturePath.isNotEmpty)
                    ? Image.file(
                        File(widget.productViewModel.picturePath),
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                      )
                    : Image.asset(
                        assetsImageFolderPath + emptyPicture,
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                      ),
              ),
              const SizedBox(height: 16),
              RatingBar.builder(
                initialRating: widget.productViewModel.rating,
                maxRating: 5,
                itemBuilder: (context, index) {
                  return const Icon(Icons.grade_rounded, color: Colors.deepPurple);
                },
                onRatingUpdate: (rating) => context.read<ProductFormCubit>().ratingChanged(rating),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: widget.productViewModel.title.value,
                focusNode: _titleFocusNode,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Title',
                  errorText: widget.productViewModel.title.isValid ? null : 'The title is empty. Please, fill it.',
                ),
                onChanged: (title) => context.read<ProductFormCubit>().titleChanged(title),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).unfocus();
                  _typeFocusNode.requestFocus();
                },
              ),
              const SizedBox(height: 16),
              SelectFormField(
                initialValue: widget.productViewModel.type.toShortString(),
                focusNode: _typeFocusNode,
                items: ProductType.values
                    .where((type) => !type.isUnknown)
                    .map<Map<String, dynamic>>((type) => {'value': type.toShortString(), 'label': type.toStringName()})
                    .toList(),
                keyboardType: TextInputType.none,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Type',
                  suffixIcon: Container(
                    width: 10,
                    margin: EdgeInsets.zero,
                    child: const Icon(Icons.arrow_drop_down, color: Colors.deepPurple),
                  ),
                ),
                onChanged: (type) {
                  context.read<ProductFormCubit>().typeChanged(toProductType(type));
                  FocusScope.of(context).unfocus();
                  _priceFocusNode.requestFocus();
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: widget.productViewModel.price.value,
                focusNode: _priceFocusNode,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: r'Price (in R$)',
                  errorText: widget.productViewModel.price.isValid ? null : 'The price is empty or wrong. Please, fix it.',
                ),
                onChanged: (price) => context.read<ProductFormCubit>().priceChanged(price),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).unfocus();
                  _descriptionFocusNode.requestFocus();
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: widget.productViewModel.description,
                maxLines: 2,
                focusNode: _descriptionFocusNode,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Description'),
                onChanged: (description) => context.read<ProductFormCubit>().descriptionChanged(description),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
