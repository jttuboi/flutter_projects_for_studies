import 'dart:io';

import 'package:flutter/material.dart';
import 'package:products/domain/utils.dart';
import 'package:products/presentation/products/view_models/product_view_model.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
    this.productViewModel, {
    required this.onEditPressed,
    required this.onDeletePressed,
    Key? key,
  }) : super(key: key);

  final ProductViewModel productViewModel;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            productViewModel.picturePath.isNotEmpty
                ? Image.file(File(productViewModel.picturePath), width: 90, height: 90)
                : Image.asset(assetsImageFolderPath + emptyPicture, width: 90, height: 90),
            const SizedBox(width: 8),
            SizedBox(
              height: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 90,
                        child: Text(productViewModel.title,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      ),
                      const SizedBox(width: 8),
                      Text(productViewModel.type, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                    ],
                  ),
                  Text(productViewModel.created, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                  Row(
                    children: [
                      ...List.filled(productViewModel.rating, const Icon(Icons.grade_rounded, color: Colors.deepPurple)),
                      ...List.filled(productViewModel.emptiesRating, Icon(Icons.grade_rounded, color: Colors.grey.shade400)),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  PopupMenuButton(
                    icon: const Icon(Icons.more_horiz_rounded, size: 36),
                    padding: EdgeInsets.zero,
                    onSelected: (value) {
                      if (value == 1) {
                        onEditPressed();
                      } else if (value == 2) {
                        onDeletePressed();
                      }
                    },
                    itemBuilder: (context) {
                      return const [
                        PopupMenuItem(value: 1, child: Text('Edit')),
                        PopupMenuItem(value: 2, child: Text('Delete')),
                      ];
                    },
                  ),
                  const Spacer(),
                  Text(productViewModel.price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
