import 'package:flutter/material.dart';
import '../constants.dart';
import 'custom_button.dart';

class MiddleGrid extends StatefulWidget {
  final List<Map<String, dynamic>> items;
  final Function(String) onItemTap;
  final int? crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const MiddleGrid({
    Key? key,
    required this.items,
    required this.onItemTap,
    this.crossAxisCount,
    this.crossAxisSpacing = 20.0,
    this.mainAxisSpacing = 20.0,
  }) : super(key: key);

  @override
  State<MiddleGrid> createState() => _MiddleGridState();
}

class _MiddleGridState extends State<MiddleGrid> {
  final ScrollController _scrollController = ScrollController();
  bool _showGradient = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 0 && _showGradient) {
        setState(() {
          _showGradient = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final int rows = widget.items.length < 5 ? 1 : 2;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double gridHeight = constraints.maxHeight - widget.mainAxisSpacing * (rows - 1);
        final double itemHeight = gridHeight / rows;
        final double itemWidth = constraints.maxWidth / (widget.crossAxisCount ?? gridCrossAxisCount);
        final double aspectRatio = itemWidth / itemHeight;

        return Stack(
          children: [
            ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false, // Hide platform scrollbars
              ),
              child: ScrollbarTheme(
                data: ScrollbarThemeData(
                  thumbColor: MaterialStateProperty.all(Colors.black.withOpacity(0.4)),
                ),
                child: Scrollbar(
                  controller: _scrollController,
                  thumbVisibility: widget.items.length > 8,
                  thickness: 8,
                  radius: const Radius.circular(5),
                  child: GridView.builder(
                    controller: _scrollController,
                    clipBehavior: Clip.none,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.crossAxisCount ?? gridCrossAxisCount,
                      crossAxisSpacing: widget.crossAxisSpacing,
                      mainAxisSpacing: widget.mainAxisSpacing,
                      childAspectRatio: aspectRatio,
                    ),
                    padding: EdgeInsets.zero,
                    itemCount: widget.items.length,
                    itemBuilder: (context, index) {
                      final item = widget.items[index];
                      final String label = item['label'] ?? '';
                      final String iconPath = item['iconPath'] ?? '';

                      return CustomButton(
                        imagePath: iconPath,
                        text: label,
                        itemCount: widget.items.length,
                        onTap: () {
                          if (item['isDisabled'] != true) {
                            widget.onItemTap(label);
                          }
                        },
                        borderColor: (label == 'Deselect' || label == 'Show Selection')
                            ? showSelectionButtonBorderColor
                            : (item['isDisabled'] == true ? Colors.grey : customButtonBorderColor),
                        backgroundColor: item['isDisabled'] == true
                            ? Colors.grey[300]!
                            : customButtonBackgroundColor,
                        textStyle: item['isDisabled'] == true
                            ? customButtonTextStyle.copyWith(color: Colors.grey)
                            : customButtonTextStyle,
                        isDisabled: item['isDisabled'] ?? false,
                      );
                    },
                  ),
                ),
              ),
            ),
            if (widget.items.length > 8 && _showGradient)
              Align(
                alignment: Alignment.bottomCenter,
                child: IgnorePointer(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
