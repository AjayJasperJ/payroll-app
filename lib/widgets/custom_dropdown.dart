import 'package:flutter/material.dart';
import 'package:payroll_hr/core/constants/images.dart';
import 'package:payroll_hr/widgets/txtfield_widget.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? defaultValue;
  final double buttonBorderRadius;
  final double dropdownBorderRadius;
  final double buttonHeight;
  final double buttonWidth;
  final double dropdownHeight;
  final Color borderColor;
  final double borderWidth;
  final Color backgroundColor;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onUpdate;
  final Color selectedColor;
  final double? textsize;

  const CustomDropdown({
    super.key,
    required this.items,
    this.defaultValue,
    this.buttonBorderRadius = 8.0,
    this.dropdownBorderRadius = 8.0,
    this.buttonHeight = 48.0,
    this.buttonWidth = 150.0,
    this.dropdownHeight = 320.0,
    this.borderColor = Colors.cyan,
    this.borderWidth = 2.0,
    this.backgroundColor = const Color(0x14B2EBF2), // Colors.cyan.withOpacity(0.08)
    this.onChanged,
    this.onUpdate,
    this.selectedColor = Colors.amber,
    this.textsize = 16,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String _selectedValue;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _dropdownOverlay;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.defaultValue ?? DateTime.now().year.toString();
    if (!widget.items.contains(_selectedValue) && widget.items.isNotEmpty) {
      _selectedValue = widget.items.first;
    }
  }

  void _showDropdown(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final Size buttonSize = button.size;
    final Offset buttonPosition = button.localToGlobal(Offset.zero, ancestor: overlay);
    _dropdownOverlay = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Dismiss area
          Positioned.fill(
            child: GestureDetector(
              onTap: _hideDropdown,
              behavior: HitTestBehavior.translucent,
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            left: buttonPosition.dx,
            top: buttonPosition.dy + buttonSize.height + 8, // 8px gap
            width: widget.buttonWidth,
            child: Material(
              elevation: 6,
              borderRadius: BorderRadius.circular(widget.dropdownBorderRadius),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: widget.borderColor, width: widget.borderWidth),
                  borderRadius: BorderRadius.circular(widget.dropdownBorderRadius),
                  color: Colors.white,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: widget.dropdownHeight),
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: widget.buttonWidth * .08),
                    shrinkWrap: true,
                    children: [
                      // Show selected item at the top if not already first
                      if (_selectedValue.isNotEmpty && widget.items.contains(_selectedValue))
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedValue = _selectedValue;
                            });
                            widget.onChanged?.call(_selectedValue);
                            widget.onUpdate?.call(_selectedValue);
                            _hideDropdown();
                          },
                          child: Container(
                            child: Center(
                              child: Txt(
                                _selectedValue,
                                color: Colors.white,
                                size: widget.textsize!,
                              ),
                            ),
                            height: widget.buttonHeight * .9,
                            margin: EdgeInsetsDirectional.symmetric(
                              horizontal: widget.buttonWidth * .06,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(widget.buttonBorderRadius),
                              ),
                              color: widget.selectedColor,
                            ),
                          ),
                        ),
                      // Show the rest of the items, excluding the selected one
                      ...widget.items.where((item) => item != _selectedValue).map((item) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedValue = item;
                            });
                            widget.onChanged?.call(item);
                            widget.onUpdate?.call(item);
                            _hideDropdown();
                          },
                          child: Container(
                            child: Center(
                              child: Txt(item, color: widget.borderColor, size: widget.textsize!),
                            ),
                            height: widget.buttonHeight * .9,
                            margin: EdgeInsetsDirectional.symmetric(
                              horizontal: widget.buttonWidth * .06,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadiusDirectional.all(
                                Radius.circular(widget.buttonBorderRadius),
                              ),
                              color: Colors.transparent,
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    Overlay.of(context, rootOverlay: true).insert(_dropdownOverlay!);
  }

  void _hideDropdown() {
    _dropdownOverlay?.remove();
    _dropdownOverlay = null;
  }

  @override
  void dispose() {
    _hideDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Builder(
        builder: (buttonContext) => SizedBox(
          width: widget.buttonWidth,
          child: InkWell(
            borderRadius: BorderRadius.circular(widget.buttonBorderRadius),
            onTap: () {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (_dropdownOverlay == null) {
                  _showDropdown(buttonContext);
                } else {
                  _hideDropdown();
                }
              });
            },
            child: Container(
              height: widget.buttonHeight,
              width: widget.buttonWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.buttonBorderRadius),
                color: widget.backgroundColor,
                border: Border.all(color: widget.borderColor, width: widget.borderWidth),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Txt(
                    _selectedValue,
                    size: widget.textsize!,
                    color: widget.borderColor,
                    font: Font.medium,
                  ),
                  txtfieldicon(context, Appicons.right_arrow, color: Colors.black),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
