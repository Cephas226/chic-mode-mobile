import 'package:flutter/material.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero(
      {Key key, this.photo, this.onTap, this.width, this.height, this.fit})
      : super(key: key);

  final String photo;
  final VoidCallback onTap;
  final double width;
  final double height;
  final BoxFit fit;

  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height:height,
      child: Hero(
        tag: photo,
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Image.network(
              photo,
              fit: fit,
            ),
          ),
        ),
      ),
    );
  }
}