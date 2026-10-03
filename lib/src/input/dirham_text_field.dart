import 'package:flutter/material.dart';
import '../dirham_icon.dart';
import 'dirham_input_formatter.dart';

/// A customizable TextFormField tailored for entering UAE Dirham currency amounts.
///
/// Features:
/// - Real-time thousands formatting via [DirhamInputFormatter]
/// - Built-in [DirhamSymbol] prefix or suffix
/// - Direct callbacks for parsed `double` and `int` (Fils) amounts
/// - Clear button toggle
/// - Min / Max amount validation helpers
class DirhamTextField extends StatefulWidget {
  /// Controller for the text field
  final TextEditingController? controller;

  /// Initial numeric amount
  final double? initialAmount;

  /// Input decoration to customize the field appearance
  final InputDecoration? decoration;

  /// Text style for the input amount
  final TextStyle? style;

  /// Symbol type to show (defaults to [DirhamSymbolType.icon])
  final DirhamSymbolType symbolType;

  /// Whether the symbol is placed in the prefix (true) or suffix (false)
  final bool symbolInPrefix;

  /// Number of decimal digits allowed (default is 2)
  final int decimalDigits;

  /// Maximum amount allowed
  final double? maxAmount;

  /// Minimum amount allowed (used in validation)
  final double? minAmount;

  /// Whether the field is enabled
  final bool enabled;

  /// Whether the field is read only
  final bool readOnly;

  /// Whether to show a clear button when text is present
  final bool showClearButton;

  /// Callback when the text changes
  final ValueChanged<String>? onChanged;

  /// Callback with parsed double amount whenever value changes
  final ValueChanged<double?>? onAmountChanged;

  /// Callback with parsed Fils whenever value changes
  final ValueChanged<int?>? onFilsChanged;

  /// Form validator callback
  final FormFieldValidator<String>? validator;

  /// Autofocus state
  final bool autofocus;

  /// FocusNode
  final FocusNode? focusNode;

  /// Text alignment
  final TextAlign textAlign;

  const DirhamTextField({
    super.key,
    this.controller,
    this.initialAmount,
    this.decoration,
    this.style,
    this.symbolType = DirhamSymbolType.icon,
    this.symbolInPrefix = true,
    this.decimalDigits = 2,
    this.maxAmount,
    this.minAmount,
    this.enabled = true,
    this.readOnly = false,
    this.showClearButton = false,
    this.onChanged,
    this.onAmountChanged,
    this.onFilsChanged,
    this.validator,
    this.autofocus = false,
    this.focusNode,
    this.textAlign = TextAlign.start,
  });

  @override
  State<DirhamTextField> createState() => _DirhamTextFieldState();
}

class _DirhamTextFieldState extends State<DirhamTextField> {
  late TextEditingController _controller;
  bool _isLocalController = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else {
      _isLocalController = true;
      final initialText = widget.initialAmount != null
          ? (widget.decimalDigits > 0
              ? widget.initialAmount!.toStringAsFixed(widget.decimalDigits)
              : widget.initialAmount!.toStringAsFixed(0))
          : '';
      _controller = TextEditingController(text: initialText);
    }

    _controller.addListener(_handleTextChange);
  }

  @override
  void didUpdateWidget(covariant DirhamTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      if (_isLocalController) {
        _controller.dispose();
      }
      if (widget.controller != null) {
        _controller = widget.controller!;
        _isLocalController = false;
      } else {
        _controller = TextEditingController();
        _isLocalController = true;
      }
      _controller.addListener(_handleTextChange);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChange);
    if (_isLocalController) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleTextChange() {
    final text = _controller.text;
    final amount = text.isEmpty ? null : DirhamInputFormatter.getUnformattedAmount(text);
    widget.onAmountChanged?.call(amount);
    if (amount != null) {
      widget.onFilsChanged?.call((amount * 100).round());
    } else {
      widget.onFilsChanged?.call(null);
    }
    setState(() {});
  }

  Widget _buildSymbol() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: DirhamSymbol(
        type: widget.symbolType,
        size: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultDecoration = widget.decoration ??
        const InputDecoration(
          border: OutlineInputBorder(),
          hintText: '0.00',
        );

    final effectiveDecoration = defaultDecoration.copyWith(
      prefixIcon: widget.symbolInPrefix ? _buildSymbol() : defaultDecoration.prefixIcon,
      suffixIcon: widget.showClearButton && _controller.text.isNotEmpty && !widget.readOnly
          ? IconButton(
              icon: const Icon(Icons.clear, size: 18),
              onPressed: () {
                _controller.clear();
                widget.onChanged?.call('');
              },
            )
          : (!widget.symbolInPrefix ? _buildSymbol() : defaultDecoration.suffixIcon),
    );

    return TextFormField(
      controller: _controller,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      textAlign: widget.textAlign,
      style: widget.style,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        DirhamInputFormatter(
          decimalDigits: widget.decimalDigits,
          maxAmount: widget.maxAmount,
        ),
      ],
      decoration: effectiveDecoration,
      onChanged: widget.onChanged,
      validator: (value) {
        if (widget.validator != null) {
          return widget.validator!(value);
        }
        if (value != null && value.isNotEmpty) {
          final amount = DirhamInputFormatter.getUnformattedAmount(value);
          if (widget.minAmount != null && amount < widget.minAmount!) {
            return 'Minimum amount is ${widget.minAmount}';
          }
          if (widget.maxAmount != null && amount > widget.maxAmount!) {
            return 'Maximum amount is ${widget.maxAmount}';
          }
        }
        return null;
      },
    );
  }
}
