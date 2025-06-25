import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:payroll_hr/app.dart';

enum Font {
  bold(FontWeight.w700),
  medium(FontWeight.w500),
  regular(FontWeight.w400),
  semiBold(FontWeight.w600);

  final FontWeight weight;
  const Font(this.weight);
}

enum Decorate {
  underline(TextDecoration.underline),
  overline(TextDecoration.overline),
  lineThrough(TextDecoration.lineThrough),
  none(TextDecoration.none);

  final TextDecoration value;
  const Decorate(this.value);
}

class Txt extends StatelessWidget {
  final String text;
  final double size;
  final Font font;
  final Color? color;
  final Decorate decorate;
  final int? max;
  final TextAlign? align;
  final TextOverflow? clip;
  final double? space;
  final double? height;

  const Txt(
    this.text, {
    super.key,
    this.size = 16,
    this.font = Font.regular,
    this.color,
    this.decorate = Decorate.none,
    this.max,
    this.align,
    this.clip,
    this.space,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: max,
      textAlign: align,
      overflow: clip,
      style: TextStyle(
        fontSize: size,
        fontWeight: font.weight,
        color: color ?? Theme.of(context).textTheme.bodyMedium?.color,
        decoration: decorate.value,
        letterSpacing: space,
        height: height,
      ),
    );
  }
}

class txtfield extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction? textInputAction;
  final bool? isPrefix;
  final List<TextInputFormatter>? inputformat;
  final TextInputType? keyboardtype;
  final bool? hidepass;
  final GestureTapCallback? onTap;
  final bool? readonly;

  const txtfield({
    super.key,
    this.onTap,
    this.controller,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.focusNode,
    this.nextFocusNode,
    this.textInputAction,
    this.isPrefix,
    this.inputformat,
    this.keyboardtype,
    this.hidepass,
    this.readonly,
  });

  @override
  State<txtfield> createState() => _txtfieldState();
}

class _txtfieldState extends State<txtfield> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _hasSubmitted = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.addListener(_handleTextChanged);
  }

  void _handleTextChanged() {
    if (_hasSubmitted) {
      _validate();
    }
  }

  void _validate() {
    if (widget.validator == null) return;
    final error = widget.validator!(_controller.text);
    setState(() => _hasError = error != null);
  }

  String? _validator(String? value) {
    if (!_hasSubmitted) return null;
    return widget.validator?.call(value);
  }

  void _handleSubmitted(String value) {
    setState(() => _hasSubmitted = true);
    _validate();

    if (widget.nextFocusNode != null) {
      widget.nextFocusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          obscureText: widget.hidepass ?? false,
          onTap: widget.onTap,
          controller: _controller,
          focusNode: _focusNode,
          textInputAction:
              widget.textInputAction ??
              (widget.nextFocusNode != null
                  ? TextInputAction.next
                  : TextInputAction.done),
          onFieldSubmitted: _handleSubmitted,
          validator: _validator,
          readOnly: widget.readonly ?? false,
          inputFormatters: widget.inputformat,
          keyboardType: widget.keyboardtype,
          decoration: InputDecoration(
            prefixIcon: !(widget.isPrefix ?? false)
                ? Container(
                    margin: EdgeInsets.only(
                      left: displaysize.height * .025,
                      right: displaysize.height * .01,
                    ),
                    height: displaysize.height * .025,
                    width: displaysize.height * .025,
                    child: widget.prefixIcon,
                  )
                : SizedBox(
                    width: displaysize.height * .13,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: displaysize.height * .015,
                        ),
                        child: widget.prefixIcon,
                      ),
                    ),
                  ),
            suffixIcon: widget.suffixIcon,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: Colors.blueAccent,
              fontWeight: Font.medium.weight,
              wordSpacing: 2,
              fontSize: displaysize.height * .016,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(displaysize.width / 4),
              borderSide: BorderSide(
                color: _hasError
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.onSurface,
                width: 1.5,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(displaysize.width / 4),
              borderSide: BorderSide(
                color: _hasError
                    ? Theme.of(context).colorScheme.error
                    : Theme.of(context).colorScheme.onSecondary,
                width: 1,
              ),
            ),
          ),
        ),
        if (_hasError && _hasSubmitted)
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 12),
            child: Text(
              widget.validator!(_controller.text) ?? '',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }
}

class txtotpfield extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;

  const txtotpfield({super.key, this.length = 4, this.onCompleted});

  @override
  State<txtotpfield> createState() => _txtotpfieldState();
}

class _txtotpfieldState extends State<txtotpfield> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;
  String _otp = '';

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
  }

  void _handleTextChange(int index, String value) {
    if (value.isNotEmpty) {
      // Only allow first character and move focus
      _controllers[index].text = value[0];

      // Move to the first empty field
      final nextEmpty = _controllers.indexWhere((c) => c.text.isEmpty);
      if (nextEmpty != -1) {
        _focusNodes[nextEmpty].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    } else {
      _handleBackspace(index);
    }

    _updateOtp();
  }

  // void _handlePaste(String pastedValue) {
  //   for (int i = 0; i < pastedValue.length; i++) {
  //     if (i < widget.length) {
  //       _controllers[i].text = pastedValue[i];
  //       if (i == pastedValue.length - 1 && i < widget.length - 1) {
  //         _focusNodes[i + 1].requestFocus();
  //       }
  //     }
  //   }
  //   _updateOtp();
  // }

  void _updateOtp() {
    final newOtp = _controllers.map((c) => c.text).join();
    if (newOtp != _otp) {
      _otp = newOtp;
      widget.onCompleted?.call(_otp);
    }
  }

  void _handleTap(int index) {
    // Focus tapped field if empty, otherwise first empty field
    if (_controllers[index].text.isEmpty) {
      _focusNodes[index].requestFocus();
    } else {
      final firstEmptyIndex = _controllers.indexWhere((c) => c.text.isEmpty);
      if (firstEmptyIndex != -1) {
        _focusNodes[firstEmptyIndex].requestFocus();
      } else {
        _focusNodes[index].requestFocus();
      }
    }
  }

  void _handleBackspace(int index) {
    if (_controllers[index].text.isNotEmpty) {
      _controllers[index].clear();
    } else {
      // Move to the previous filled field
      for (int i = index - 1; i >= 0; i--) {
        if (_controllers[i].text.isNotEmpty) {
          _controllers[i].clear();
          _focusNodes[i].requestFocus();
          break;
        }
      }
    }
    _updateOtp();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(widget.length, (index) {
        return SizedBox(
          width: displaysize.height * .095,
          height: displaysize.height * .065,
          child: RawKeyboardListener(
            focusNode: FocusNode(),
            onKey: (event) {
              if (event.logicalKey == LogicalKeyboardKey.backspace) {
                _handleBackspace(index);
              }
            },
            child: GestureDetector(
              onTap: () => _handleTap(index),
              child: TextFormField(
                controller: _controllers[index],
                focusNode: _focusNodes[index],
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(1),
                ],
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
                    borderRadius: BorderRadius.circular(displaysize.width / 4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(displaysize.width / 4),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
                onChanged: (value) => _handleTextChange(index, value),
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }
}

txtfieldicon(context, String imagepath) {
  return SizedBox(
    height: displaysize.height * .022,
    width: displaysize.height * .022,
    child: Center(
      child: Image.asset(
        imagepath,
        height: displaysize.height * .022,
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
    ),
  );
}
