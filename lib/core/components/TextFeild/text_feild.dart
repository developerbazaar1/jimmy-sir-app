import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jimmy_sir_app/core/constants/app_colors.dart';


class AppTextField extends StatefulWidget {
  final String? prefixIconImg;
  final String? suffixIcon;
  final String? labelText; // label INSIDE field (Material style)
  final String? Function(String?)? validator;
  final bool isPassword;
  final bool readOnly;
  final String? hint;
  final String? defaultText;
  final void Function()? onTap;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final double? fontSize;
  final double? labelFontSize;

  const AppTextField({
    super.key,
    this.prefixIconImg,
    this.suffixIcon,
    this.labelText,
    this.validator,
    this.isPassword = false,
    this.onTap,
    this.controller,
    this.hint,
    this.defaultText,
    this.readOnly = false,
    this.keyboardType,
    this.focusNode,
    this.fontSize,
    this.labelFontSize,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  final _fieldKey = GlobalKey<FormFieldState<String>>();
  bool obscure = true;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      widget.focusNode!.addListener(_onFocusChange);
    }
  }

  @override
  void dispose() {
    if (widget.focusNode != null) {
      widget.focusNode!.removeListener(_onFocusChange);
    }
    super.dispose();
  }

  void _onFocusChange() {
    if (widget.focusNode!.hasFocus) {
      setState(() => obscure = false);
    } else {
      setState(() => obscure = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    Color borderColor;
    if (_errorText != null) {
      borderColor = AppColor.redColor;
    } else if (widget.focusNode != null && widget.focusNode!.hasFocus) {
      borderColor = AppColor.primaryColor;
    } else {
      borderColor = AppColor.border;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Outer bordered container that reacts to validation
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: borderColor, width: 1.4),
            color: Colors.transparent,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.prefixIconImg != null) ...[
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    widget.prefixIconImg!,
                    height: 22,
                    width: 22,
                  ),
                ),
                Container(width: 1, height: 40, color: AppColor.border),
              ],
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    
                    key: _fieldKey,
                    onTap: widget.onTap,
                    focusNode: widget.focusNode,
                    controller: widget.controller,
                    keyboardType: widget.keyboardType,
                    readOnly: widget.readOnly,
                    obscureText: widget.isPassword ? obscure : false,
                    cursorColor: AppColor.primaryColor,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'urbanist',
                      fontSize: widget.fontSize ?? width * 0.046,
                      color: AppColor.placeholderColor,
                    ),
                    decoration: InputDecoration(
                      // Label floats inside field per your screenshot
                      labelText: widget.labelText,
                      labelStyle: TextStyle(
                        fontSize: widget.labelFontSize ?? width * 0.046,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'urbanist',
                        color: AppColor.placeholderColor,
                      ),
                      hintText: widget.hint ?? widget.defaultText,
                      isDense: true,
                      // remove internal borders; we use the outer container border
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                        top: 4,
                        left: 12,
                        right: 0,
                      ),
                      // trailing icons
                      suffixIcon: _buildSuffix(),
                    ),
                    validator: (value) {
                      final res = widget.validator?.call(value);
                      // update your outer border + external error text
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted && _errorText != res)
                          setState(() => _errorText = res);
                      });
                      return null;
                    },
                  ),
                ),
              ),
              // If password, show eye toggle at the very end (outside TF suffix slot so padding stays neat)
              if (widget.isPassword)
                InkWell(
                  onTap: () => setState(() => obscure = !obscure),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  mouseCursor: SystemMouseCursors.basic,
                  borderRadius: BorderRadius.circular(12),

                  splashFactory: NoSplash.splashFactory,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: obscure
                        ? Icon(Icons.visibility_off, color: AppColor.border)
                        : Icon(Icons.visibility, color: AppColor.border),
                  ),
                ),
              // If not password and suffix provided, show it at the end
              if (!widget.isPassword && widget.suffixIcon != null)
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    widget.suffixIcon!,
                    height: 22,
                    width: 22,
                  ),
                ),
            ],
          ),
        ),

        // Error text OUTSIDE (below) the bordered container
        if (_errorText != null) ...[
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Text(
              _errorText!,
              style: TextStyle(
                color: Colors.red.shade600,
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ],
    );
  }

  // When not password, you can still use the TextField's suffix slot for extra icons (optional)
  Widget? _buildSuffix() {
    // we render suffix outside the field for consistent paddings (see end of Row),
    // but if you prefer inside, comment out the Row-suffix above and return it here instead.
    return null;
  }
}
