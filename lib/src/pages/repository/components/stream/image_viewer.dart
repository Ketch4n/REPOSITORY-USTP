import 'package:flutter/material.dart';

class ImagePreview extends StatelessWidget {
  final String fileUrl;

  const ImagePreview({super.key, required this.fileUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      fileUrl,
      fit: BoxFit.contain,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    (loadingProgress.expectedTotalBytes ?? 1)
                : null,
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return const Center(child: Text('Failed to load image'));
      },
    );
  }
}
