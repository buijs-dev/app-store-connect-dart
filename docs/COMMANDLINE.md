# Usage: Command-line
- [Setup](#Setup)
- [Certificates](#Certificates)
- [Provisioning](#Provisioning)
- [BundleId](#BundleId)


## Setup
There are 4 ways to provide credentials for authentication, in order of precedence (high to low):
- [Key arguments](#Key%20arguments)
- [Environment keys](#Environment%20keys)
- [apple_keys.json path](#Custom%20JSON%20path)
- [apple_keys.json default path](#Default%20JSON%20path)

##### Key arguments
If the keys are set by the command-line arguments then these will always take precedence.

```shell

    flutter pub run app_store_client:<command> \
        --issuer-id ISSUER_ID \
        --key-id KEY_IDENTIFIER \
        --private-key PRIVATE_KEY

```

##### Environment keys
Instead of passing the keys for every request they can also be set as environment variables.

```shell

  export APP_STORE_CONNECT_ISSUER_ID="ISSUER_ID"  
  export APP_STORE_CONNECT_KEY_IDENTIFIER="KEY_IDENTIFIER"    
  export APP_STORE_CONNECT_PRIVATE_KEY="PRIVATE_KEY"      

  flutter pub run app_store_client:<command>

```

##### Custom JSON path
If you use the apple_keys.json file you can pass the absolute path to the file:

```shell

  flutter pub run app_store_client:<command> --key-file "/Users/obi-wan/twins/apple_keys.json"

```

##### Default JSON path
By default the command-line tool will check the current directory for an apple_keys.json file.

```shell

  flutter pub run app_store_client:<command>

```

## Certificates
Find all signing certificates. Available filter options:
1. --id
2. --serial-number
3. --display-name
4. --path

Example: find a specific signing certificate by ID:

```shell

  flutter pub run app_store_client:certificates-find --id "ANIDEA"

```

Multiple value can be supplied by using a comma separated String value.
Example: find signing certificates by multiple ID:
```shell

  flutter pub run app_store_client:certificates-find --id "ANIDEA,NOIDEA,SOMEIDEA,IDEAS"

```

Example: find a specific signing certificate by ID, serialNumber and/or displayName:

```shell

  flutter pub run app_store_client:certificates-find \
  --id "ANIDEA,NOIDEA" \
  --serial-number "12345,9864" \
  --display-name "fancy name,less fancy name,nancy"

```

By default the certificates will be stored in <i>$HOME/Library/MobileDevice/Certificates</i>.
This can be overridden by using the <i>path</i> option:

```shell

  flutter pub run app_store_client:certificates-find \
  --path "/Users/Luke/loves/clouds"
  
```

## Provisioning

## BundleId