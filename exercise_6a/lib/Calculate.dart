class Calculate{

  String _output="";
  String _curnum = "";
  double result = 0.0;

  List<String> _s1=[],_s2=[];
  List<double> _s3=[];

  String get Output => this._output;

  static const numKeys = [ '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  static const calKeys = ['+','x','/','—'];
  static const equalKey = '=';
  static const clearKeys = ['C'];

  static Map<String, int> calKeyMap = {"/":2, "x":2,"—":1,"+":1};
  List<String> _keys = [];

  void addKey(String key) {
    if (clearKeys.contains(key)) {
      _s1 = [];
      _s2 = [];
      _s3 = [];
      _curnum = "";
      _output = "";
      _keys = [];
      return;
    }
    String prekey = "";
    if (_keys.length > 0) {
      prekey = _keys[_keys.length - 1];
    }

    if (numKeys.contains(key)) {
      if (_curnum.isEmpty && _s1.isEmpty) {
        _output = "";
      }
      _output += key;
      _curnum += key;
      _keys.add(key);
    } else {
      if (_curnum.isNotEmpty) {
        _s1.add(_curnum);
        _curnum = "";
      }
    }

    if (calKeyMap.containsKey(key)) {
      if (_s1.length == 0) {
        String rs = result.toString();
        _output = rs;
        for (int i = 0; i < rs.length; i++) {
          _keys.add(rs.substring(i, i + 1));
        }
        _s1.add(rs);
      }
      if (calKeyMap.containsKey(prekey)) {
        removeLastKey();
      }
      _keys.add(key);
      _output += key;
      if (_s2.length == 0) {
        _s2.add(key);
      } else {

        String lastkey = _s2[_s2.length - 1];
          if (calKeyMap[key]! <= calKeyMap[lastkey]!) {
            while (_s2.length > 0 &&
                calKeyMap[key] !<= calKeyMap[_s2[_s2.length - 1]]!) {
              _s1.add(_s2.removeLast());
            }
          }

        _s2.add(key);
      }
    }

    if ( equalKey == key && (_s1.length > 0 || _curnum.isNotEmpty) && prekey != equalKey) {
      if (calKeys.contains(prekey)) {
        removeLastKey();
      }
      _keys.add(key);
      _output += key;
      while (_s2.length > 0) {
        _s1.add(_s2.removeLast());
      }
      for (int i = 0; i < _s1.length; i++) {
        String k = _s1[i];
        if (!calKeys.contains(k)) {
          _s3.add(double.parse(k));
        } else {
          switch (k) {
            case "+":
              _s3.add(_s3.removeLast() + _s3.removeLast());
              break;
            case "x":
              _s3.add(_s3.removeLast() * _s3.removeLast());
              break;
            case "—":
              double r1 = _s3.removeLast(), r2 = _s3.removeLast();
              _s3.add(r2 - r1);
              break;
            case "/":
              double r1 = _s3.removeLast(), r2 = _s3.removeLast();
              _s3.add(r2 / r1);
              break;
          }
        }
      }

      result = _s3[0];
      _output += "$result";
      _s3 = [];
      _s2 = [];
      _s1 = [];
      _keys = [];
    }
  }

  void removeLastKey() {
    String prekey = "";
    if (_keys.length > 0) {
      prekey = _keys[_keys.length - 1];
    }
    print(_s1);
    print(_s2);
    if (calKeys.contains(prekey)) {

      String k1 = _s1[_s1.length - 1];
      if (calKeys.contains(k1)) {
        _s2.removeLast();
        for (int i = _s1.length - 1; i >= 0; i--) {
          String tk = _s1[i];
          if (calKeys.contains(tk)) {
            _s2.add(_s1.removeLast());
          } else {
            break;
          }
        }
      } else {
        _s2.removeLast();
      }
      _output = _output.substring(0, _output.length - 1);
      _keys.removeLast();
    } else if (_s1.length > 0 || _curnum.isNotEmpty) {
      if (_curnum.isNotEmpty) {
        _curnum = _curnum.substring(0, _curnum.length - 1);
      } else {
        String tk = _s1.removeLast();
        tk = tk.substring(0, tk.length - 1);
        if (tk.isNotEmpty) {
          _s1.add(tk);
        }
      }
      _output = _output.substring(0, _output.length - 1);
      _keys.removeLast();
    }
  }

}