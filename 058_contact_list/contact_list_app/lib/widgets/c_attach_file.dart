import 'package:flutter/material.dart';

// não está completo
class CAttachFile extends StatelessWidget {
  const CAttachFile({required this.title, required this.hint, required this.icon, required this.filePathNotifier, this.onPressed, super.key});

  final String title;
  final String hint;
  final IconData icon;
  final ValueNotifier<String> filePathNotifier;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: InkWell(
                onTap: onPressed,
                child: Container(
                  constraints: BoxConstraints.tight(const Size(300, 44)),
                  decoration: ShapeDecoration(
                    shape: ContinuousRectangleBorder(side: const BorderSide(color: Colors.grey), borderRadius: BorderRadius.circular(8)),
                  ),
                  padding: const EdgeInsets.only(left: 12, right: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ValueListenableBuilder<String>(
                          valueListenable: filePathNotifier,
                          builder: (_, filePath, __) {
                            return Flexible(
                              child: CustomScrollView(
                                scrollDirection: Axis.horizontal,
                                slivers: [
                                  SliverPadding(
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                    sliver: SliverToBoxAdapter(
                                        child: Text(filePath.isNotEmpty ? filePath : hint, style: TextStyle(color: Colors.grey.shade700))),
                                  ),
                                ],
                              ),
                            );
                          }),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 8),
                            child: Container(width: 1, height: 34, color: Colors.grey),
                          ),
                          Icon(icon, color: Colors.grey.shade700),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // if (errorFilePath != null)
            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Text(errorFilePath, style: TextStyle(fontSize: 12, color: Colors.red.shade700)),
            //   )
          ],
        ),
        Positioned(
          left: 8,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ),
        ),
      ],
    );
  }
}
