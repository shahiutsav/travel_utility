import 'package:flutter/material.dart';

class StackedCard extends StatelessWidget {
  const StackedCard({
    this.height = 200,
    this.width = 200,
    this.color = Colors.amber,
    this.child,
    this.enableTap = false,
    this.onTap,
    super.key,
  });

  final double width;
  final double height;
  final Widget? child;
  final Color color;
  final bool enableTap;
  final VoidCallback? onTap;
  static const double paddingSize = 12.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // Create a container with the specified width and height
      width: width,
      height: height,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // Get the maximum available width and height
          double containerWidth = constraints.maxWidth;
          double containerHeight = constraints.maxHeight;

          // Create a stack with two positioned containers
          return Stack(
            children: [
              Positioned(
                bottom: 0,
                right: 0,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: containerWidth - paddingSize,
                    maxWidth: containerWidth - paddingSize,
                    minHeight: containerHeight - paddingSize,
                    maxHeight: containerHeight - paddingSize,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(
                        color: Colors.black,
                        width: 4,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: containerWidth - paddingSize,
                  maxWidth: containerWidth - paddingSize,
                  minHeight: containerHeight - paddingSize,
                  maxHeight: containerHeight - paddingSize,
                ),
                child: enableTap
                    ? InkWell(
                        onTap: onTap,
                        child: _buildContainer(),
                      )
                    : _buildContainer(),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black,
          width: 4,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }
}
