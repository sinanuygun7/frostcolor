import 'package:flutter/material.dart';

class FrostColor {
  /// Hex Code Convert to Color

  /// Constructor with a default hex value of black (#000000)
  FrostColor({String hex = '#000000'}) : _hexcode = hex {
    /// Perform initial validation or setup
    _startControl();

    /// Convert the hex code to a proper format if necessary
    _convertHex();

    /// Convert the hex code to a color representation
    _convertColor();

    /// Perform final checks or processing
    _endControl();
  }

  /// variables
  String _hexcode;

  /// Hex Code
  late String _hexstr;

  /// Hex Code String
  late Color _hexclr;

  /// Added for fast execution only converts to hexcode color,
  ///  assuming the hexcode conforms to the rules, without any checks.

  Color ffColor(String hex) =>
  /// Fast Color Functions
  Color(int.parse('FF${hex.replaceAll('#', '')}', radix: 16));

  /// Hex Code Color

  void _startControl() {
    /// control hex code
    /// add control regexp
    final hexPattern = RegExp(
      r'^#([0-9A-Fa-f]{3}|[0-9A-Fa-f]{6}|[0-9A-Fa-f]{8})$',
    );

    if (!hexPattern.hasMatch(_hexcode)) {
      /// First character change "#"
      if (!_hexcode.startsWith('#')) {
        _hexcode = '#$_hexcode';
      }

      /// It should not contain only “#”.
      String hex = _hexcode.replaceAll('#', '').toUpperCase();

      /// Changing invalid characters to F.
      hex = hex.replaceAll(RegExp(r'[^0-9A-Fa-f]'), 'F');

      /// modifield hex code character number
      if (!(hex.length == 3 || hex.length == 6 || hex.length == 8)) {
        if (hex.isEmpty) {
          hex = '000000';
        } else if (hex.length == 1) {
          hex = '$hex$hex$hex';
        } else if (hex.length == 2) {
          hex = '${hex[0]}${hex[1]}${hex[1]}';
        } else if (hex.length == 4) {
          hex = '${hex[0]}${hex[1]}${hex[2]}${hex[3]}${hex[3]}${hex[3]}';
        } else if (hex.length == 5) {
          hex = '${hex[0]}${hex[1]}${hex[2]}${hex[3]}${hex[4]}${hex[4]}';
        } else if (hex.length == 7) {
          hex = '${hex}F';
        }
      }

      /// hex code length control
      if (hex.length > 8) {
        hex.substring(0, 8);
      }

      _hexcode = '#$hex';
    }
  }

  void _endControl() {
    /// color format control
    /// 000000 colors is  transparent
    if (_hexcode == '#000' ||
        _hexcode == '#000000' ||
        _hexcode == '#00000000') {
      _hexclr = Colors.transparent;
    }
  }

  void _convertHex() {
    /// hex code convert hex
    _hexstr = 'FF${_hexcode.replaceAll('#', '')}';
  }

  void _convertColor() {
    /// hex code convert color
    _hexclr = Color(int.parse(_hexstr, radix: 16));
  }

  String strHex(String hex) {
    /// Returns the value of a String
    /// ```dart
    /// context.strHexColor('#000000')
    /// ```
    _hexcode = hex;
    _startControl();
    _convertHex();
    return _hexstr;
  }

  int intHex(String hex) {
    return int.parse('FF${hex.replaceAll('#', '')}', radix: 16);
  }

  Color clrHex(String hex) {
    /// Returns the value of a Color
    /// context.clrHexColor('#000000')
    /// ```
    _hexcode = hex;
    _startControl();
    _convertHex();
    _convertColor();
    _endControl();
    return _hexclr;
  }
}

class DFColor extends Color {
  /// DFColor is DirectFrostColor

  /// Factory constructor to create a DFColor instance
  factory DFColor(String hex) {
    return DFColor._internal(_fastConvert(hex));
  }

  /// Private constructor that calls Color's constructor
  DFColor._internal(super.colorValue);

  /// Function to convert hex to integer for Color
  static int _fastConvert(String hex) {
    return int.parse('FF${hex.replaceAll('#', '')}', radix: 16);
  }

  /// `value` yerine `toARGB32()` kullan
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is Color) {
      return toARGB32() == other.toARGB32();
    }
    return false;
  }

  @override
  int get hashCode => toARGB32().hashCode;
}
