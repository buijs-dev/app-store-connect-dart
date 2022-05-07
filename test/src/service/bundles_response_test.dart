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

import 'package:app_store_connect/src/service/bundles_response.dart';
import 'package:test/test.dart';

void main() async {
  test('Verify BundleIdsResponse JSON deserialization', () async {
    final response = BundleIdsResponse.fromJson(json);
    expect(response.data.length, 7);
  });
}

const json = """{
  "data" : [ {
    "type" : "bundleIds",
    "id" : "298GKSC854",
    "attributes" : {
      "name" : "exampleapp",
      "identifier" : "dev.buijs.bundle.some",
      "platform" : "UNIVERSAL",
      "seedId" : "3UUFR2FHC6"
    },
    "relationships" : {
      "bundleIdCapabilities" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/298GKSC854/relationships/bundleIdCapabilities",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/298GKSC854/bundleIdCapabilities"
        }
      },
      "profiles" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/298GKSC854/relationships/profiles",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/298GKSC854/profiles"
        }
      }
    },
    "links" : {
      "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/298GKSC854"
    }
  }, {
    "type" : "bundleIds",
    "id" : "65MAAHDPUX",
    "attributes" : {
      "name" : "XC Wildcard",
      "identifier" : "*",
      "platform" : "UNIVERSAL",
      "seedId" : "3UUFR2FHC6"
    },
    "relationships" : {
      "bundleIdCapabilities" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/65MAAHDPUX/relationships/bundleIdCapabilities",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/65MAAHDPUX/bundleIdCapabilities"
        }
      },
      "profiles" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/65MAAHDPUX/relationships/profiles",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/65MAAHDPUX/profiles"
        }
      }
    },
    "links" : {
      "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/65MAAHDPUX"
    }
  }, {
    "type" : "bundleIds",
    "id" : "6B2RSS47DN",
    "attributes" : {
      "name" : "XC dev buijs delivery example deliveryExample",
      "identifier" : "dev.buijs.delivery.example.deliveryExample",
      "platform" : "UNIVERSAL",
      "seedId" : "3UUFR2FHC6"
    },
    "relationships" : {
      "bundleIdCapabilities" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/6B2RSS47DN/relationships/bundleIdCapabilities",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/6B2RSS47DN/bundleIdCapabilities"
        }
      },
      "profiles" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/6B2RSS47DN/relationships/profiles",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/6B2RSS47DN/profiles"
        }
      }
    },
    "links" : {
      "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/6B2RSS47DN"
    }
  }, {
    "type" : "bundleIds",
    "id" : "8K6856MQGM",
    "attributes" : {
      "name" : "Flutter Delivery Example",
      "identifier" : "dev.buijs.flutter.delivery.example",
      "platform" : "UNIVERSAL",
      "seedId" : "3UUFR2FHC6"
    },
    "relationships" : {
      "bundleIdCapabilities" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/8K6856MQGM/relationships/bundleIdCapabilities",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/8K6856MQGM/bundleIdCapabilities"
        }
      },
      "profiles" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/8K6856MQGM/relationships/profiles",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/8K6856MQGM/profiles"
        }
      }
    },
    "links" : {
      "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/8K6856MQGM"
    }
  }, {
    "type" : "bundleIds",
    "id" : "NJJ4BY6XZG",
    "attributes" : {
      "name" : "delivery example",
      "identifier" : "dev.buijs.delivery.example",
      "platform" : "UNIVERSAL",
      "seedId" : "3UUFR2FHC6"
    },
    "relationships" : {
      "bundleIdCapabilities" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/NJJ4BY6XZG/relationships/bundleIdCapabilities",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/NJJ4BY6XZG/bundleIdCapabilities"
        }
      },
      "profiles" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/NJJ4BY6XZG/relationships/profiles",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/NJJ4BY6XZG/profiles"
        }
      }
    },
    "links" : {
      "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/NJJ4BY6XZG"
    }
  }, {
    "type" : "bundleIds",
    "id" : "XQL5SB78VC",
    "attributes" : {
      "name" : "Monsterdex a guide to Monster Masters EX",
      "identifier" : "dev.buijs.games.monsterdex",
      "platform" : "UNIVERSAL",
      "seedId" : "3UUFR2FHC6"
    },
    "relationships" : {
      "bundleIdCapabilities" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/XQL5SB78VC/relationships/bundleIdCapabilities",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/XQL5SB78VC/bundleIdCapabilities"
        }
      },
      "profiles" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/XQL5SB78VC/relationships/profiles",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/XQL5SB78VC/profiles"
        }
      }
    },
    "links" : {
      "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/XQL5SB78VC"
    }
  }, {
    "type" : "bundleIds",
    "id" : "Z468FDJ8VU",
    "attributes" : {
      "name" : "MonsterdEX",
      "identifier" : "dev.buijs.monsterdex",
      "platform" : "UNIVERSAL",
      "seedId" : "3UUFR2FHC6"
    },
    "relationships" : {
      "bundleIdCapabilities" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/Z468FDJ8VU/relationships/bundleIdCapabilities",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/Z468FDJ8VU/bundleIdCapabilities"
        }
      },
      "profiles" : {
        "meta" : {
          "paging" : {
            "total" : 0,
            "limit" : 2147483647
          }
        },
        "links" : {
          "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/Z468FDJ8VU/relationships/profiles",
          "related" : "https://api.appstoreconnect.apple.com/v1/bundleIds/Z468FDJ8VU/profiles"
        }
      }
    },
    "links" : {
      "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds/Z468FDJ8VU"
    }
  } ],
  "links" : {
    "self" : "https://api.appstoreconnect.apple.com/v1/bundleIds"
  },
  "meta" : {
    "paging" : {
      "total" : 7,
      "limit" : 20
    }
  }
}""";
