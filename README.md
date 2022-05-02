[![GitHub license](https://img.shields.io/github/license/buijs-dev/dart-apple-client)](#License)

# App Store Client
A pure Dart client for the App Store Connect Api. The client can be used from Dart/Flutter code or  
from CLI. All App Store Connect resources/tasks are/will be available through this library. 

# About App Store Connect API
Because the client gives access to all functionality from the App Store Connect API, it's good to know
what this API can do. [App Store Connect API](https://developer.apple.com/documentation/appstoreconnectapi) 
is a REST service that lets you 'Automate the tasks you perform on the Apple Developer website and in App Store Connect.'

The API provides resources to automate the following areas of App Store Connect:

- TestFlight. Manage beta builds of your app, testers, and groups.

- Xcode Cloud. Read Xcode Cloud data, manage workflows, and start builds.

- Users and Roles. Send invitations for users to join your team. Adjust their level of access or remove users.

- Provisioning. Manage bundle IDs, capabilities, signing certificates, devices, and provisioning profiles.

- App Metadata. Create new versions, manage App Store information, and submit your app to the App Store.

- App Clip Experiences. Create an App Clip and manage App Clip experiences.

- Reporting. Download sales and financial reports.

- Power and Performance Metrics. Download aggregate metrics and diagnostics for App Store versions of your app.

# Installation

## Add dependenccy
Add app_store_client to your pubspec.yaml:

```yaml
dependencies:
  app_store_client: ^1.0.0
```

Run:

``` shell
flutter pub get
```


## Setup API keys
The client will authenticate to the App Store Connect API by creating a JSON web token.
For this it requires API Keys. If you don't have these yet you can create the keys by following
[these](https://developer.apple.com/documentation/appstoreconnectapi/creating_api_keys_for_app_store_connect_api) steps.

The API keys need to be stored in the file <B>apple_keys.json</B>. Create it by running the keyfile command in the root folder
of your project:

```shell

flutter pub run app_store_client:keyfile

````

This will generate a JSON file:

```json
    {
      "private_key_id": "The private key ID from App Store Connect",
      "private_key": "The private key file (content) from App Store Connect.",
      "issuer_id": "The issuer ID from the API keys page in App Store Connect."
    }
```

Fill in the keys data and of course do <B>NOT</B> save this file in VCS. Make sure to add it to your gitignore file.

# Usage
The client can be used from Dart code directly or from the command-line:
- [Code]()
- [Command-line]()

# Usage: Code
- [Setup](#Setup)
- [Certificates](#Certificates)
- [Provisioning](#Provisioning)
- [BundleId](#BundleId)

## Setup

```dart

/// Read the apple_keys.json file.
final pathToJson = "${Directory.current.path}apple_keys.json";

/// Create an AppStoreCredentials instance.
final credentials = AppStoreCredentials.fromFile(pathToJson);

/// Create an AppStoreConnect instance.
/// Now you can use the service to communicate with App Store Connect.  
final service = AppStoreConnect(credentials);

```

## Certificates

```dart

/// Retrieve all certificates.
await service.certificates.find().then((certificates) => print(certificates));

/// Execute a query to find a specific Certificate:  
await service.certificates.find((_) => _
    ..filterId = ["1234NOIDEA"]
    ..filterSerialNumber = ["FOOBAR123"]
    ..filterDisplayName = ["Beautiful Display"]
    ..limit = 1)
    .then((certificate) => print(certificate));

/// Limit the response data returned:  
await service.certificates.find((_) => _
    ..showDisplayName
    ..showCsrContent)
    .then((certificates) => print(certificates));

/// Find certificate by ID:  
await service.certificates.findById("1234NOIDEA");

/// Find by ID with limited response data returned:  
await service.certificates.findById("1234NOIDEA",
    show: (_) => _
    ..showDisplayName
    ..showCsrContent
    ..showName);

```

## Provisioning

## BundleId




# Usage: Command-line
//TODO


# Roadmap
//TODO 



## Contributing
Pull requests are welcome. Contact me at info@buijs.dev

## License
MIT License

Copyright (c) [2021] [Buijs Software]

Permission is hereby granted, free of charge, to any person obtaining a copy  
of this software and associated documentation files (the "Software"), to deal  
in the Software without restriction, including without limitation the rights  
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell  
copies of the Software, and to permit persons to whom the Software is  
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all  
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,  
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE  
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER  
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,  
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE  
SOFTWARE.