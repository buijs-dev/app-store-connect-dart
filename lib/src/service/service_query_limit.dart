// Copyright (c) 2021 - 2022 Buijs Software
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

/// [Author] Gillian Buijs.
abstract class QueryLimit {
  final warnings = <String>[];

  int _maxLimit = 200;

  int? get limit => _limit;

  /// Limit the number results returned.
  int? _limit;

  set limit(int? limit) {
    final limitNotNull = limit ?? _maxLimit;

    /// If limit is less than 1 then log a warning and set the limit to 1.
    if (limitNotNull < 1) {
      warnings.add(""
          "Specified limit is invalid: $limit"
          "Why do you want to see less than 1 certificate!?"
          "Setting limit to: '1'");
      _limit = 1;
    }

    /// If the limit is more than 50 then log a warning and set to max value.
    else if (limitNotNull > _maxLimit) {
      warnings.add(""
          "Specified limit exceeds the maximum value: $limit"
          "Setting limit to maximum value: '$_maxLimit'");
      _limit = _maxLimit;
    }

    /// Set the limit because the requested value is within acceptable range.
    else {
      _limit = limitNotNull;
    }
  }
}

extension QueryLimitter on QueryLimit {
  void setMaxLimit(int limit) {
    _maxLimit = limit;
  }
}
