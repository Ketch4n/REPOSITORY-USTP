import 'package:flutter/material.dart';
import 'package:repository_ustp/src/pages/repository/components/pages/utils/page4_text.dart';

class Page4TextModule extends StatelessWidget {
  const Page4TextModule({super.key, required this.string});
  final String string;

  @override
  Widget build(BuildContext context) {
    return Text(
      string.toUpperCase(),
      style: Page4TextUtils.lt,
      softWrap: true,
      textWidthBasis: TextWidthBasis.longestLine,
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }
}
