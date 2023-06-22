import 'package:nav2_flutter_community/common/dimens/app_dimens.dart';
import 'package:flutter/material.dart';

class InProgressMessage extends StatelessWidget {
  const InProgressMessage({
    required this.screenName,
    required this.progressName,
    Key? key,
  }) : super(key: key);

  final String screenName;
  final String progressName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.SIZE_SPACING_MEDIUM),
        child: Text(
          '$progressName is in progress...\n\nStill in $screenName\n\n',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
