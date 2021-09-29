import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClick;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            child: buildEditIcon(color),
            bottom: 0,
            right: 4,
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(
            onTap: onClick,
          ),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 10,
      child: const Icon(
        Icons.edit,
        size: 20,
        color: Colors.white,
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color
  }) => ClipOval(
    child: Container(
      child: child,
      color: color,
      padding: EdgeInsets.all(all),
    ),
  );
}
