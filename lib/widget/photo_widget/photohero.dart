import 'package:flutter/material.dart';

class PhotoHero extends StatelessWidget {
  const PhotoHero(
      { required this.photo, required this.onTap, required this.width,  this.height});
  final String photo;
  final VoidCallback onTap;
  final double width;
  final double? height;
  //final BoxFit fit;

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
              //fit: fit,
            ),
          ),
        ),
      ),
    );
  }
}
