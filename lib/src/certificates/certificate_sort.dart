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


/// Query parameters used to sort the [CertificatesResponse].
///
/// [Author] Gillian Buijs.
enum CertificatesSort {
  certificateTypeAsc,
  certificateTypeDesc,
  displayNameAsc,
  displayNameDesc,
  idAsc,
  idDesc,
  serialNumberAsc,
  serialNumberDesc,
}

/// Helper to serialize [CertificatesSort] enumeration.
///
/// [Author] Gillian Buijs.
extension CertificatesSortExt on CertificatesSort {

  String get serialize {
    switch(this) {
      case CertificatesSort.certificateTypeAsc:
        return "certificateType";
      case CertificatesSort.certificateTypeDesc:
        return "-certificateType";
      case CertificatesSort.displayNameAsc:
        return "displayName";
      case CertificatesSort.displayNameDesc:
        return "-displayName";
      case CertificatesSort.idAsc:
        return "id";
      case CertificatesSort.idDesc:
        return "-id";
      case CertificatesSort.serialNumberAsc:
        return "serialNumber";
      case CertificatesSort.serialNumberDesc:
        return "-serialNumber";
    }
  }

}