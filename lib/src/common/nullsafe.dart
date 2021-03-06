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

/// Value wrapper to facilitate handling null values.
///
/// [Author] Gillian Buijs.
class Optional<T> {
  const Optional(this.value);

  final T? value;

  /// Return the value or use the fallback action if value is null.
  T orElse(Function() orElse) {
    if (value == null) {
      return orElse.call();
    } else {
      return value!;
    }
  }

  /// Return the value or throw exception if value is null.
  T orElseThrow(Exception e) {
    if (value == null) {
      return throw e;
    } else {
      return value!;
    }
  }

  /// Execute an action on the value Object if it is not null.
  ///
  /// Return [Optional] with new value or this instance with null value.
  Optional<R> map<R>(R Function(T) action) {
    if (value != null) {
      return Optional(action(value!));
    } else {
      return Optional(null);
    }
  }

  /// Terminal operation which executes an action if a value is present.
  ///
  /// Return [T] or null if no value is present.
  R? mapOrNull<R>(R Function(T) action) {
    if (value != null) {
      return action(value!);
    } else {
      return null;
    }
  }
}
