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

    /// Retrieve all certificates:
    await service.certificates.find()
      .then((certificates) => print(certificates));
    
    /// Sort the certificates ascending by ID:
    await service.certificates.find((_) => _
      ..sortByIdAsc)
      .then((certificates) => print(certificates));
    
    /// Sort the certificates descending by ID:
    await service.certificates.find((_) => _
      ..sortByIdDesc)
      .then((certificates) => print(certificates));
    
    /// Sort the certificates ascending by CertificateType:
    await service.certificates.find((_) => _
      ..sortByCertificateTypeAsc)
      .then((certificates) => print(certificates));
    
    /// Sort the certificates descending by CertificateType:
    await service.certificates.find((_) => _
      ..sortByCertificateTypeDesc)
      .then((certificates) => print(certificates));
    
    /// Sort the certificates ascending by DisplayName:
    await service.certificates.find((_) => _
      ..sortByDisplayNameAsc)
      .then((certificates) => print(certificates));
    
    /// Sort the certificates descending by DisplayName:
    await service.certificates.find((_) => _
      ..sortByDisplayNameDesc)
      .then((certificates) => print(certificates));
    
    /// Sort the certificates ascending by SerialNumber:
    await service.certificates.find((_) => _
      ..sortBySerialNumberAsc)
      .then((certificates) => print(certificates));
    
    /// Sort the certificates descending by SerialNumber:
    await service.certificates.find((_) =>_
      ..sortBySerialNumberDesc)
      .then((certificates) => print(certificates));
    
    /// Or execute a query to find a specific Certificate:
    await service.certificates.find((_) => _
        ..filterId = ["1234NOIDEA"]
        ..filterSerialNumber = ["FOOBAR123"]
        ..filterDisplayName = ["Beautiful Display"]
        ..limit = 1)
        .then((certificate) => print(certificate));
    
    /// Limit the response data returned:
    await service.certificates.find((_) => _
        ..showDisplayName
        ..showCsrContent
        ..showName
        ..showCsrContent
        ..showExpirationDate
        ..showCertificateType
        ..showPlatform
        ..showSerialNumber)
        .then((certificates) => print(certificates));
    
    /// Find by ID:
    await service.certificates.findById("1234NOIDEA");
    
    /// Find by ID and only return the name:
    await service.certificates.findById("1234NOIDEA", show: (_) => _..showName);

```

## BundleId

```dart

    /// Retrieve all bundleIds:
    await service.bundles.find()
      .then((bundleIds) => print(bundleIds));

    /// Retrieve bundleIds with profiles and capabilities
    await service.find(
            capabilities: (_) => _
                  ..showBundleId
                  ..showCapabilityType
                  ..showSettings
                  ..limit = 50,
            profiles:  (_) => _
                  ..showBundleId
                  ..showCertificates
                  ..showDevices
                  ..showExpirationData
                  ..showName
                  ..showPlatform
                  ..showProfileContent
                  ..showProfileState
                  ..showProfileType
                  ..showUUID
                  ..limit = 50,
            bundles: (_) => _
                  ..showCapabilities
                  ..showIdentifier
                  ..showName
                  ..showPlatform
                  ..showProfiles
                  ..showSeedId
                  ..filterId = ["IDEA123"]
                  ..filterIdentifier = ["IDENTIFIER123"]
                  ..filterName = ["BUNDLE,NAME,NONAME"]
                  ..filterPlatformIsMacOS
                  ..filterPlatformIsIOS
                  ..filterSeedId = ["SEEDID,OVER9000"]
                  ..limit = 200
                  ..sortByIdAsc
                  ..sortByIdDesc
                  ..sortByIdentifierAsc
                  ..sortByIdentifierDesc
                  ..sortByNameAsc
                  ..sortByNameDesc
                  ..sortByPlatformAsc
                  ..sortByPlatformDesc
                  ..sortBySeedIdAsc
                  ..sortBySeedIdDesc
                  ..includeProfiles
                  ..includeCapabilities
        );


```

## Provisioning