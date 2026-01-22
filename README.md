# Sui MVR

Move Registry (MVR, pronounced "mover") provides a uniform naming service for interacting and building with packages from the Sui ecosystem. This means that you can reference packages by their names, and MVR resolves the package address for you, despite the network.

Use MVR to:

Reference both packages and types by name in programmable transaction blocks (PTBs).

Depend on other packages when developing with Move.

Additionally, MVR can help you manage package versioning. With MVR, you call a specific version of a package without having to resolve the addresses yourself. You also don't need to worry about the package being updated, because if you use a name without a specified version, MVR automatically defaults to the latest version available.

## Resources

https://github.com/MystenLabs/mvr

https://docs.suins.io/move-registry

https://www.moveregistry.com/apps


## See registered packages
```bash
sui client new-env --alias mainnet --rpc https://fullnode.mainnet.sui.io:443
sui client switch --env mainnet
sui client dynamic-field 0xe8417c530cde59eddf6dfb760e8a0e3e2c6f17c69ddaab5a73dd6a6e65fc463b
```

## Testing MVR

First install Sui CLI if you haven't already:
https://docs.sui.io/guides/developer/getting-started/sui-install

### Initialize Sui Testnet:

```bash
# Create new if it doesn't exist
sui client new-env --alias testnet --rpc https://fullnode.testnet.sui.io:443
sui client switch --network testnet
```

### Get funds

```bash
sui client active-address
# go to sui discord faucet channel and request testnet SUI https://discord.com/channels/916379725201563759/1037811694564560966
sui client gas
```

### Create new Move package

Install move CLI: https://docs.suins.io/move-registry/tooling/mvr-cli
```bash
# cargo install here, but there are also binaries available
cargo install --locked --git https://github.com/mystenlabs/mvr --branch release mvr
```

#### Create new package
```bash
sui move new ascii_vec
cd ascii_vec
```

#### Resolve package with MVR

Resolve a package:
```bash
mvr resolve @potatoes/ascii
```

#### Add dependency with MVR

```bash
mvr add @potatoes/ascii
```
Outputs:
```text
[mvr] detected supported SUI CLI version

Successfully added dependency @potatoes/ascii to your Move.toml

You can use this dependency in your modules by calling: use ascii::<module>;
```

```bash
sui move build
```

Output:
```text
Output from mvr:
  │ [mvr] detected supported SUI CLI version
  │ [mvr] resolving: "@potatoes/ascii" on network:  mainnet

Downloading from https://github.com/MystenLabs/sui.git
INCLUDING DEPENDENCY MoveStdlib
INCLUDING DEPENDENCY Sui
INCLUDING DEPENDENCY ascii
BUILDING ascii_example
```

### Publish package
```bash
sui client switch --env testnet
sui client publish ascii_vec
``
Output:
```text
Output from mvr:
  │ [mvr] detected supported SUI CLI version
  │ [mvr] resolving: "@potatoes/ascii" on network:  testnet

INCLUDING DEPENDENCY MoveStdlib
INCLUDING DEPENDENCY Sui
INCLUDING DEPENDENCY ascii
BUILDING ascii_vec
Transaction Digest: 3RSyAKUSb7KHfcvPdLcCdFSkf8HbtxT5YGU6nvyAkyFA
╭──────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Transaction Data                                                                                             │
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Sender: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                                   │
│ Gas Owner: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                                │
│ Gas Budget: 8817200 MIST                                                                                     │
│ Gas Price: 1000 MIST                                                                                         │
│ Gas Payment:                                                                                                 │
│  ┌──                                                                                                         │
│  │ ID: 0x46e938cd9b09e42b54678b1729710f39f53c443079d78a6bcfd284554372ff65                                    │
│  │ Version: 1299417                                                                                          │
│  │ Digest: 73QqwbqZPtH66igrxfLsyJndc4u9hyNgvHCk4mEeKyVS                                                      │
│  └──                                                                                                         │
│                                                                                                              │
│ Transaction Kind: Programmable                                                                               │
│ ╭──────────────────────────────────────────────────────────────────────────────────────────────────────────╮ │
│ │ Input Objects                                                                                            │ │
│ ├──────────────────────────────────────────────────────────────────────────────────────────────────────────┤ │
│ │ 0   Pure Arg: Type: address, Value: "0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1" │ │
│ ╰──────────────────────────────────────────────────────────────────────────────────────────────────────────╯ │
│ ╭─────────────────────────────────────────────────────────────────────────╮                                  │
│ │ Commands                                                                │                                  │
│ ├─────────────────────────────────────────────────────────────────────────┤                                  │
│ │ 0  Publish:                                                             │                                  │
│ │  ┌                                                                      │                                  │
│ │  │ Dependencies:                                                        │                                  │
│ │  │   0x0000000000000000000000000000000000000000000000000000000000000001 │                                  │
│ │  │   0x65d106ccd0feddc4183dcaa92decafd3376ee9b34315aae938dc838f6d654f18 │                                  │
│ │  └                                                                      │                                  │
│ │                                                                         │                                  │
│ │ 1  TransferObjects:                                                     │                                  │
│ │  ┌                                                                      │                                  │
│ │  │ Arguments:                                                           │                                  │
│ │  │   Result 0                                                           │                                  │
│ │  │ Address: Input  0                                                    │                                  │
│ │  └                                                                      │                                  │
│ ╰─────────────────────────────────────────────────────────────────────────╯                                  │
│                                                                                                              │
│ Signatures:                                                                                                  │
│    DZs+dmQg77LUrA7wWZqVE1uH8OGUw4FrJUHdm5LP26CK1QRw9aRYoS62/4MTzbqXYTNug046EOvWX7nwNLWIBw==                  │
│                                                                                                              │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭───────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Transaction Effects                                                                               │
├───────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Digest: 3RSyAKUSb7KHfcvPdLcCdFSkf8HbtxT5YGU6nvyAkyFA                                              │
│ Status: Success                                                                                   │
│ Executed Epoch: 987                                                                               │
│                                                                                                   │
│ Created Objects:                                                                                  │
│  ┌──                                                                                              │
│  │ ID: 0xb1753600c9878b986e2f78f7e72c1592e6af3761c7eb6263f365c679c8a443e7                         │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )  │
│  │ Version: 1299418                                                                               │
│  │ Digest: AuA5musE7xdXCN6UJNjbfvtKrzDQuMkuojCzjAg7JBnd                                           │
│  └──                                                                                              │
│  ┌──                                                                                              │
│  │ ID: 0xb5e52cb86f621dd85f9b8c478de49f3d31535467cebb1c558be34889eef4e39c                         │
│  │ Owner: Immutable                                                                               │
│  │ Version: 1                                                                                     │
│  │ Digest: F7gEBC3V3Qxsfk3RW3e8fdZXtStvnjKXeies9hQDDRV5                                           │
│  └──                                                                                              │
│ Mutated Objects:                                                                                  │
│  ┌──                                                                                              │
│  │ ID: 0x46e938cd9b09e42b54678b1729710f39f53c443079d78a6bcfd284554372ff65                         │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )  │
│  │ Version: 1299418                                                                               │
│  │ Digest: 3nzSxWQ3RWZH2CrxsvKtZZQQUdvMW85Gar88AbtrQrAq                                           │
│  └──                                                                                              │
│ Gas Object:                                                                                       │
│  ┌──                                                                                              │
│  │ ID: 0x46e938cd9b09e42b54678b1729710f39f53c443079d78a6bcfd284554372ff65                         │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )  │
│  │ Version: 1299418                                                                               │
│  │ Digest: 3nzSxWQ3RWZH2CrxsvKtZZQQUdvMW85Gar88AbtrQrAq                                           │
│  └──                                                                                              │
│ Gas Cost Summary:                                                                                 │
│    Storage Cost: 6817200 MIST                                                                     │
│    Computation Cost: 1000000 MIST                                                                 │
│    Storage Rebate: 978120 MIST                                                                    │
│    Non-refundable Storage Fee: 9880 MIST                                                          │
│                                                                                                   │
│ Transaction Dependencies:                                                                         │
│    51zGpY2N7jTkNgEbjyquKTZtsjmP9Ak1mJX85RjP44Hx                                                   │
│    8knq2EBSFLZFPha55F97BJ4Cp4xM2wa13ytkjQB9rL1Y                                                   │
│    B5W8jPYhhxoLZswrEnZ6z6HUog9jwHciKTt3NEbE5p73                                                   │
╰───────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─────────────────────────────╮
│ No transaction block events │
╰─────────────────────────────╯

╭──────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Object Changes                                                                                   │
├──────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Created Objects:                                                                                 │
│  ┌──                                                                                             │
│  │ ObjectID: 0xb1753600c9878b986e2f78f7e72c1592e6af3761c7eb6263f365c679c8a443e7                  │
│  │ Sender: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                    │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 ) │
│  │ ObjectType: 0x2::package::UpgradeCap                                                          │
│  │ Version: 1299418                                                                              │
│  │ Digest: AuA5musE7xdXCN6UJNjbfvtKrzDQuMkuojCzjAg7JBnd                                          │
│  └──                                                                                             │
│ Mutated Objects:                                                                                 │
│  ┌──                                                                                             │
│  │ ObjectID: 0x46e938cd9b09e42b54678b1729710f39f53c443079d78a6bcfd284554372ff65                  │
│  │ Sender: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                    │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 ) │
│  │ ObjectType: 0x2::coin::Coin<0x2::sui::SUI>                                                    │
│  │ Version: 1299418                                                                              │
│  │ Digest: 3nzSxWQ3RWZH2CrxsvKtZZQQUdvMW85Gar88AbtrQrAq                                          │
│  └──                                                                                             │
│ Published Objects:                                                                               │
│  ┌──                                                                                             │
│  │ PackageID: 0xb5e52cb86f621dd85f9b8c478de49f3d31535467cebb1c558be34889eef4e39c                 │
│  │ Version: 1                                                                                    │
│  │ Digest: F7gEBC3V3Qxsfk3RW3e8fdZXtStvnjKXeies9hQDDRV5                                          │
│  │ Modules: ascii_vec                                                                            │
│  └──                                                                                             │
╰──────────────────────────────────────────────────────────────────────────────────────────────────╯
╭───────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Balance Changes                                                                                   │
├───────────────────────────────────────────────────────────────────────────────────────────────────┤
│  ┌──                                                                                              │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )  │
│  │ CoinType: 0x2::sui::SUI                                                                        │
│  │ Amount: -6839080                                                                               │
│  └──                                                                                              │
╰───────────────────────────────────────────────────────────────────────────────────────────────────╯
```


### Register package with MVR

MVR registration is a two-step process:
1. **Create a `PackageInfo` object** - This holds metadata for your package and acts as proof of ownership
2. **Register the MVR name** - Associate your package with a SuiNS name on Mainnet

> **Note:** The MVR registry exists only on Mainnet. For testnet packages, you register a pointer on Mainnet that points to your testnet package.


#### Prerequisites
- A SuiNS name (e.g., `yourname.sui`) - Get one at https://suins.io
- Your `UpgradeCap` object ID from the publish transaction (e.g., `0xb1753600c9878b986e2f78f7e72c1592e6af3761c7eb6263f365c679c8a443e7`)
- Your published package ID (e.g., `0xb5e52cb86f621dd85f9b8c478de49f3d31535467cebb1c558be34889eef4e39c`)


#### Step 1: Create PackageInfo object (on the network where package is published)

https://docs.suins.io/move-registry/managing-package-info

Create a `PackageInfo` object using your `UpgradeCap`:

```bash
# Switch to the network where your package is published
sui client switch --env testnet

# Create PackageInfo object
# Extract upgrade-capability
UPGRADE_CAP=$(grep 'upgrade-capability' ascii_vec/Published.toml | awk -F'"' '{print $2}')

# MAINNET_MVR_METADATA_PACKAGE_ID=0xc88768f8b26581a8ee1bf71e6a6ec0f93d4cc6460ebb66a31b94d64de8105c98 # @mvr/metadata
TESTNET_MVR_METADATA_PACKAGE_ID=0xb96f44d08ae214887cae08d8ae061bbf6f0908b1bfccb710eea277f45150b9f4 # @mvr/metadata
SUINS_NAME="@iota-a"
PACKAGE_NAME="ascii_vec"

sui client ptb \
--move-call $TESTNET_MVR_METADATA_PACKAGE_ID::package_info::new @$UPGRADE_CAP --assign packageinfo \
--move-call $TESTNET_MVR_METADATA_PACKAGE_ID::display::default \"$PACKAGE_NAME\" --assign display \
--move-call $TESTNET_MVR_METADATA_PACKAGE_ID::package_info::set_display packageinfo display \
--move-call $TESTNET_MVR_METADATA_PACKAGE_ID::package_info::set_metadata packageinfo \"default\" \"$SUINS_NAME/$PACKAGE_NAME\" \
--move-call sui::tx_context::sender --assign sender \
--move-call $TESTNET_MVR_METADATA_PACKAGE_ID::package_info::transfer packageinfo sender \
--dry-run # run without --dry-run to actually execute
```

Output:
```text
Transaction Digest: E2VPH1B3MwY6Rf2K9PwD3HsaB5AEGy9xcwTgRjsCQRYv
╭─────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Transaction Data                                                                                │
├─────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Sender: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                      │
│ Gas Owner: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                   │
│ Gas Budget: 9335140 MIST                                                                        │
│ Gas Price: 1000 MIST                                                                            │
│ Gas Payment:                                                                                    │
│  ┌──                                                                                            │
│  │ ID: 0x46e938cd9b09e42b54678b1729710f39f53c443079d78a6bcfd284554372ff65                       │
│  │ Version: 1299418                                                                             │
│  │ Digest: 3nzSxWQ3RWZH2CrxsvKtZZQQUdvMW85Gar88AbtrQrAq                                         │
│  └──                                                                                            │
│                                                                                                 │
│ Transaction Kind: Programmable                                                                  │
│ ╭─────────────────────────────────────────────────────────────────────────────────────────────╮ │
│ │ Input Objects                                                                               │ │
│ ├─────────────────────────────────────────────────────────────────────────────────────────────┤ │
│ │ 0   Imm/Owned Object ID: 0xb1753600c9878b986e2f78f7e72c1592e6af3761c7eb6263f365c679c8a443e7 │ │
│ │ 1   Pure Arg: Type: 0x1::string::String, Value: "ascii_vec"                                 │ │
│ │ 2   Pure Arg: Type: 0x1::string::String, Value: "default"                                   │ │
│ │ 3   Pure Arg: Type: 0x1::string::String, Value: "@iota-a/ascii_vec"                         │ │
│ ╰─────────────────────────────────────────────────────────────────────────────────────────────╯ │
│ ╭──────────────────────────────────────────────────────────────────────────────────╮            │
│ │ Commands                                                                         │            │
│ ├──────────────────────────────────────────────────────────────────────────────────┤            │
│ │ 0  MoveCall:                                                                     │            │
│ │  ┌                                                                               │            │
│ │  │ Function:  new                                                                │            │
│ │  │ Module:    package_info                                                       │            │
│ │  │ Package:   0xb96f44d08ae214887cae08d8ae061bbf6f0908b1bfccb710eea277f45150b9f4 │            │
│ │  │ Arguments:                                                                    │            │
│ │  │   Input  0                                                                    │            │
│ │  └                                                                               │            │
│ │                                                                                  │            │
│ │ 1  MoveCall:                                                                     │            │
│ │  ┌                                                                               │            │
│ │  │ Function:  default                                                            │            │
│ │  │ Module:    display                                                            │            │
│ │  │ Package:   0xb96f44d08ae214887cae08d8ae061bbf6f0908b1bfccb710eea277f45150b9f4 │            │
│ │  │ Arguments:                                                                    │            │
│ │  │   Input  1                                                                    │            │
│ │  └                                                                               │            │
│ │                                                                                  │            │
│ │ 2  MoveCall:                                                                     │            │
│ │  ┌                                                                               │            │
│ │  │ Function:  set_display                                                        │            │
│ │  │ Module:    package_info                                                       │            │
│ │  │ Package:   0xb96f44d08ae214887cae08d8ae061bbf6f0908b1bfccb710eea277f45150b9f4 │            │
│ │  │ Arguments:                                                                    │            │
│ │  │   Result 0                                                                    │            │
│ │  │   Result 1                                                                    │            │
│ │  └                                                                               │            │
│ │                                                                                  │            │
│ │ 3  MoveCall:                                                                     │            │
│ │  ┌                                                                               │            │
│ │  │ Function:  set_metadata                                                       │            │
│ │  │ Module:    package_info                                                       │            │
│ │  │ Package:   0xb96f44d08ae214887cae08d8ae061bbf6f0908b1bfccb710eea277f45150b9f4 │            │
│ │  │ Arguments:                                                                    │            │
│ │  │   Result 0                                                                    │            │
│ │  │   Input  2                                                                    │            │
│ │  │   Input  3                                                                    │            │
│ │  └                                                                               │            │
│ │                                                                                  │            │
│ │ 4  MoveCall:                                                                     │            │
│ │  ┌                                                                               │            │
│ │  │ Function:  sender                                                             │            │
│ │  │ Module:    tx_context                                                         │            │
│ │  │ Package:   0x0000000000000000000000000000000000000000000000000000000000000002 │            │
│ │  └                                                                               │            │
│ │                                                                                  │            │
│ │ 5  MoveCall:                                                                     │            │
│ │  ┌                                                                               │            │
│ │  │ Function:  transfer                                                           │            │
│ │  │ Module:    package_info                                                       │            │
│ │  │ Package:   0xb96f44d08ae214887cae08d8ae061bbf6f0908b1bfccb710eea277f45150b9f4 │            │
│ │  │ Arguments:                                                                    │            │
│ │  │   Result 0                                                                    │            │
│ │  │   Result 4                                                                    │            │
│ │  └                                                                               │            │
│ ╰──────────────────────────────────────────────────────────────────────────────────╯            │
│                                                                                                 │
│ Signatures:                                                                                     │
│    Q5GlqXntFrhd4QZEGe/lBw8SuH5Y58fJjvlMV9tL6uv5z+BWbXa7Gg71ymtoHxh53hVgUHGH+sXJTb1zymkwBw==     │
│                                                                                                 │
╰─────────────────────────────────────────────────────────────────────────────────────────────────╯
╭───────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Transaction Effects                                                                               │
├───────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Digest: E2VPH1B3MwY6Rf2K9PwD3HsaB5AEGy9xcwTgRjsCQRYv                                              │
│ Status: Success                                                                                   │
│ Executed Epoch: 987                                                                               │
│                                                                                                   │
│ Created Objects:                                                                                  │
│  ┌──                                                                                              │
│  │ ID: 0x3c754c8358191d0f5333c52dccc9148b757b347928ed6025472be4dfe0a16290                         │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )  │
│  │ Version: 1299419                                                                               │
│  │ Digest: 7jqmEarzVAWP7ahwqDTLPg8K5jrq3iu7mRejkrTdn6Kt                                           │
│  └──                                                                                              │
│ Mutated Objects:                                                                                  │
│  ┌──                                                                                              │
│  │ ID: 0x46e938cd9b09e42b54678b1729710f39f53c443079d78a6bcfd284554372ff65                         │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )  │
│  │ Version: 1299419                                                                               │
│  │ Digest: DeAbKNbRagTGq1dJSzivCbgeDJuEgW4CpYBukEtCQdan                                           │
│  └──                                                                                              │
│  ┌──                                                                                              │
│  │ ID: 0xb1753600c9878b986e2f78f7e72c1592e6af3761c7eb6263f365c679c8a443e7                         │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )  │
│  │ Version: 1299419                                                                               │
│  │ Digest: 6FMw2EMwTPmu57mS2VuN5FDxTt79MwZ3rvrmuyDUUg5r                                           │
│  └──                                                                                              │
│ Gas Object:                                                                                       │
│  ┌──                                                                                              │
│  │ ID: 0x46e938cd9b09e42b54678b1729710f39f53c443079d78a6bcfd284554372ff65                         │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )  │
│  │ Version: 1299419                                                                               │
│  │ Digest: DeAbKNbRagTGq1dJSzivCbgeDJuEgW4CpYBukEtCQdan                                           │
│  └──                                                                                              │
│ Gas Cost Summary:                                                                                 │
│    Storage Cost: 8952800 MIST                                                                     │
│    Computation Cost: 1000000 MIST                                                                 │
│    Storage Rebate: 2595780 MIST                                                                   │
│    Non-refundable Storage Fee: 26220 MIST                                                         │
│                                                                                                   │
│ Transaction Dependencies:                                                                         │
│    3RSyAKUSb7KHfcvPdLcCdFSkf8HbtxT5YGU6nvyAkyFA                                                   │
│    B5W8jPYhhxoLZswrEnZ6z6HUog9jwHciKTt3NEbE5p73                                                   │
│    DXqQzTTeKLWFoxmjYH1BNaH9136YFskUKfxyCWYsrUsF                                                   │
╰───────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─────────────────────────────╮
│ No transaction block events │
╰─────────────────────────────╯

╭───────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Object Changes                                                                                                │
├───────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Created Objects:                                                                                              │
│  ┌──                                                                                                          │
│  │ ObjectID: 0x3c754c8358191d0f5333c52dccc9148b757b347928ed6025472be4dfe0a16290                               │
│  │ Sender: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                                 │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )              │
│  │ ObjectType: 0xb96f44d08ae214887cae08d8ae061bbf6f0908b1bfccb710eea277f45150b9f4::package_info::PackageInfo  │
│  │ Version: 1299419                                                                                           │
│  │ Digest: 7jqmEarzVAWP7ahwqDTLPg8K5jrq3iu7mRejkrTdn6Kt                                                       │
│  └──                                                                                                          │
│ Mutated Objects:                                                                                              │
│  ┌──                                                                                                          │
│  │ ObjectID: 0x46e938cd9b09e42b54678b1729710f39f53c443079d78a6bcfd284554372ff65                               │
│  │ Sender: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                                 │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )              │
│  │ ObjectType: 0x2::coin::Coin<0x2::sui::SUI>                                                                 │
│  │ Version: 1299419                                                                                           │
│  │ Digest: DeAbKNbRagTGq1dJSzivCbgeDJuEgW4CpYBukEtCQdan                                                       │
│  └──                                                                                                          │
│  ┌──                                                                                                          │
│  │ ObjectID: 0xb1753600c9878b986e2f78f7e72c1592e6af3761c7eb6263f365c679c8a443e7                               │
│  │ Sender: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                                 │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )              │
│  │ ObjectType: 0x2::package::UpgradeCap                                                                       │
│  │ Version: 1299419                                                                                           │
│  │ Digest: 6FMw2EMwTPmu57mS2VuN5FDxTt79MwZ3rvrmuyDUUg5r                                                       │
│  └──                                                                                                          │
╰───────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭───────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Balance Changes                                                                                   │
├───────────────────────────────────────────────────────────────────────────────────────────────────┤
│  ┌──                                                                                              │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )  │
│  │ CoinType: 0x2::sui::SUI                                                                        │
│  │ Amount: -7357020                                                                               │
│  └──                                                                                              │
╰───────────────────────────────────────────────────────────────────────────────────────────────────╯
```

Extract the `PackageInfo` object ID for the next steps.
```bash
PACKAGE_INFO_ID=0x3c754c8358191d0f5333c52dccc9148b757b347928ed6025472be4dfe0a16290
```

Update metadata later (because I messed up the name format):
```bash
sui client switch --env testnet
PACKAGE_INFO_ID=0x3c754c8358191d0f5333c52dccc9148b757b347928ed6025472be4dfe0a16290
SUINS_NAME="@iota-a"
PACKAGE_NAME="ascii-vec" # with - instead of _ as registered in SuiNS
sui client ptb \
--move-call @mvr/metadata::package_info::unset_metadata @$PACKAGE_INFO_ID \"default\" \
--move-call @mvr/metadata::package_info::set_metadata @$PACKAGE_INFO_ID \"default\" \"$SUINS_NAME/$PACKAGE_NAME\" \
--dry-run # run without --dry-run to actually execute
```
Update display later:
```bash
sui client switch --env testnet
PACKAGE_INFO_ID=0x3c754c8358191d0f5333c52dccc9148b757b347928ed6025472be4dfe0a16290
PACKAGE_NAME="ascii-vec"
sui client ptb \
--move-call @mvr/metadata::display::default \"$PACKAGE_NAME\" --assign display \
--move-call @mvr/metadata::package_info::set_display @$PACKAGE_INFO_ID display \
--dry-run # run without --dry-run to actually execute
```

#### Step 2: Register application on Mainnet

https://docs.suins.io/move-registry/mvr-names#Attach-a-non-Mainnet-package-to-an-application

Switch to Mainnet and register your application with your SuiNS name:

```bash
sui client switch --env mainnet

SUINS_REGISTRATION=0x31c89ea3dedaddefa8ddec47e50bd3242fe385f35ac39979a91ee4074c7ad8ad # @iota-a
MOVE_REGISTRY=0x0e5d473a055b6b7d014af557a13ad9075157fdc19b6d51562a18511afd397727

# Extract original-id (package ID)
ORIGINAL_PACKAGE_ID=$(grep 'original-id' ascii_vec/Published.toml | awk -F'"' '{print $2}')

PACKAGE_NAME="ascii-vec"
TESTNET_CHAIN_ID=4c78adac

METADATA_KEY="description"
METADATA_VALUE="ASCII vector utilities for Move"

# Register new application and set network + metadata
sui client ptb \
--move-call @mvr/core::move_registry::register @$MOVE_REGISTRY @$SUINS_REGISTRATION "\"$PACKAGE_NAME\"" @0x6 --assign app_cap \
--move-call 0x1::option::some "<0x2::object::ID>" @$PACKAGE_INFO_ID \
--assign packageInfo \
--move-call 0x1::option::some "<address>" @$ORIGINAL_PACKAGE_ID \
--assign packageId \
--move-call 0x1::option::none "<0x2::object::ID>" \
--assign null \
--move-call @mvr/core::app_info::new packageInfo packageId null \
--assign appInfo \
--move-call @mvr/core::move_registry::set_network @$MOVE_REGISTRY app_cap \"$TESTNET_CHAIN_ID\" appInfo \
--move-call @mvr/core::move_registry::set_metadata @$MOVE_REGISTRY app_cap \"$METADATA_KEY\" \"$METADATA_VALUE\" \
--move-call sui::tx_context::sender --assign sender \
--transfer-objects '[app_cap]' sender \
--dry-run # run without --dry-run to actually execute
```

This creates an `AppCap` object that you'll use to manage your MVR registration.

Output:
```text
╭─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Transaction Data                                                                                                                        │
├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Sender: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                                                              │
│ Gas Owner: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                                                           │
│ Gas Budget: 10803468 MIST                                                                                                               │
│ Gas Price: 500 MIST                                                                                                                     │
│ Gas Payment:                                                                                                                            │
│  ┌──                                                                                                                                    │
│  │ ID: 0xba583898cf6f4ad7fa7d8d1d9ec205137158589237e8ce476d87d64c5a0692bb                                                               │
│  │ Version: 760374646                                                                                                                   │
│  │ Digest: 3Ry5mbj4yRrD4iBVekxYd5HTFNSzVCLdVYJiNTXGDY5w                                                                                 │
│  └──                                                                                                                                    │
│                                                                                                                                         │
│ Transaction Kind: Programmable                                                                                                          │
│ ╭─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮ │
│ │ Input Objects                                                                                                                       │ │
│ ├─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤ │
│ │ 0   Shared Object    ID: 0x0e5d473a055b6b7d014af557a13ad9075157fdc19b6d51562a18511afd397727                                         │ │
│ │ 1   Imm/Owned Object ID: 0x31c89ea3dedaddefa8ddec47e50bd3242fe385f35ac39979a91ee4074c7ad8ad                                         │ │
│ │ 2   Pure Arg: Type: 0x1::string::String, Value: "ascii-vec"                                                                         │ │
│ │ 3   Shared Object    ID: 0x0000000000000000000000000000000000000000000000000000000000000006                                         │ │
│ │ 4   Pure Arg: [60,117,76,131,88,25,29,15,83,51,197,45,204,201,20,139,117,123,52,121,40,237,96,37,71,43,228,223,224,161,98,144]      │ │
│ │ 5   Pure Arg: [181,229,44,184,111,98,29,216,95,155,140,71,141,228,159,61,49,83,84,103,206,187,28,85,139,227,72,137,238,244,227,156] │ │
│ │ 6   Pure Arg: Type: 0x1::string::String, Value: "4c78adac"                                                                          │ │
│ │ 7   Pure Arg: Type: 0x1::string::String, Value: "description"                                                                       │ │
│ │ 8   Pure Arg: Type: 0x1::string::String, Value: "ASCII vector utilities for Move"                                                   │ │
│ ╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯ │
│ ╭──────────────────────────────────────────────────────────────────────────────────╮                                                    │
│ │ Commands                                                                         │                                                    │
│ ├──────────────────────────────────────────────────────────────────────────────────┤                                                    │
│ │ 0  MoveCall:                                                                     │                                                    │
│ │  ┌                                                                               │                                                    │
│ │  │ Function:  register                                                           │                                                    │
│ │  │ Module:    move_registry                                                      │                                                    │
│ │  │ Package:   0xbb97fa5af2504cc944a8df78dcb5c8b72c3673ca4ba8e4969a98188bf745ee54 │                                                    │
│ │  │ Arguments:                                                                    │                                                    │
│ │  │   Input  0                                                                    │                                                    │
│ │  │   Input  1                                                                    │                                                    │
│ │  │   Input  2                                                                    │                                                    │
│ │  │   Input  3                                                                    │                                                    │
│ │  └                                                                               │                                                    │
│ │                                                                                  │                                                    │
│ │ 1  MoveCall:                                                                     │                                                    │
│ │  ┌                                                                               │                                                    │
│ │  │ Function:  some                                                               │                                                    │
│ │  │ Module:    option                                                             │                                                    │
│ │  │ Package:   0x0000000000000000000000000000000000000000000000000000000000000001 │                                                    │
│ │  │ Type Arguments:                                                               │                                                    │
│ │  │   0x2::object::ID                                                             │                                                    │
│ │  │ Arguments:                                                                    │                                                    │
│ │  │   Input  4                                                                    │                                                    │
│ │  └                                                                               │                                                    │
│ │                                                                                  │                                                    │
│ │ 2  MoveCall:                                                                     │                                                    │
│ │  ┌                                                                               │                                                    │
│ │  │ Function:  some                                                               │                                                    │
│ │  │ Module:    option                                                             │                                                    │
│ │  │ Package:   0x0000000000000000000000000000000000000000000000000000000000000001 │                                                    │
│ │  │ Type Arguments:                                                               │                                                    │
│ │  │   address                                                                     │                                                    │
│ │  │ Arguments:                                                                    │                                                    │
│ │  │   Input  5                                                                    │                                                    │
│ │  └                                                                               │                                                    │
│ │                                                                                  │                                                    │
│ │ 3  MoveCall:                                                                     │                                                    │
│ │  ┌                                                                               │                                                    │
│ │  │ Function:  none                                                               │                                                    │
│ │  │ Module:    option                                                             │                                                    │
│ │  │ Package:   0x0000000000000000000000000000000000000000000000000000000000000001 │                                                    │
│ │  │ Type Arguments:                                                               │                                                    │
│ │  │   0x2::object::ID                                                             │                                                    │
│ │  └                                                                               │                                                    │
│ │                                                                                  │                                                    │
│ │ 4  MoveCall:                                                                     │                                                    │
│ │  ┌                                                                               │                                                    │
│ │  │ Function:  new                                                                │                                                    │
│ │  │ Module:    app_info                                                           │                                                    │
│ │  │ Package:   0xbb97fa5af2504cc944a8df78dcb5c8b72c3673ca4ba8e4969a98188bf745ee54 │                                                    │
│ │  │ Arguments:                                                                    │                                                    │
│ │  │   Result 1                                                                    │                                                    │
│ │  │   Result 2                                                                    │                                                    │
│ │  │   Result 3                                                                    │                                                    │
│ │  └                                                                               │                                                    │
│ │                                                                                  │                                                    │
│ │ 5  MoveCall:                                                                     │                                                    │
│ │  ┌                                                                               │                                                    │
│ │  │ Function:  set_network                                                        │                                                    │
│ │  │ Module:    move_registry                                                      │                                                    │
│ │  │ Package:   0xbb97fa5af2504cc944a8df78dcb5c8b72c3673ca4ba8e4969a98188bf745ee54 │                                                    │
│ │  │ Arguments:                                                                    │                                                    │
│ │  │   Input  0                                                                    │                                                    │
│ │  │   Result 0                                                                    │                                                    │
│ │  │   Input  6                                                                    │                                                    │
│ │  │   Result 4                                                                    │                                                    │
│ │  └                                                                               │                                                    │
│ │                                                                                  │                                                    │
│ │ 6  MoveCall:                                                                     │                                                    │
│ │  ┌                                                                               │                                                    │
│ │  │ Function:  set_metadata                                                       │                                                    │
│ │  │ Module:    move_registry                                                      │                                                    │
│ │  │ Package:   0xbb97fa5af2504cc944a8df78dcb5c8b72c3673ca4ba8e4969a98188bf745ee54 │                                                    │
│ │  │ Arguments:                                                                    │                                                    │
│ │  │   Input  0                                                                    │                                                    │
│ │  │   Result 0                                                                    │                                                    │
│ │  │   Input  7                                                                    │                                                    │
│ │  │   Input  8                                                                    │                                                    │
│ │  └                                                                               │                                                    │
│ │                                                                                  │                                                    │
│ │ 7  MoveCall:                                                                     │                                                    │
│ │  ┌                                                                               │                                                    │
│ │  │ Function:  sender                                                             │                                                    │
│ │  │ Module:    tx_context                                                         │                                                    │
│ │  │ Package:   0x0000000000000000000000000000000000000000000000000000000000000002 │                                                    │
│ │  └                                                                               │                                                    │
│ │                                                                                  │                                                    │
│ │ 8  TransferObjects:                                                              │                                                    │
│ │  ┌                                                                               │                                                    │
│ │  │ Arguments:                                                                    │                                                    │
│ │  │   Result 0                                                                    │                                                    │
│ │  │ Address: Result 7                                                             │                                                    │
│ │  └                                                                               │                                                    │
│ ╰──────────────────────────────────────────────────────────────────────────────────╯                                                    │
│                                                                                                                                         │
│ Signatures:                                                                                                                             │
│    CTbomSSuUSAJ9qh+uE+jpzUlv87R2196TkcXEg7LG1N7CLh28B+ObGZNX1LIZQr6YUTEtY85yAyCR4Wu6yk6Bg==                                             │
│                                                                                                                                         │
╰─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭───────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Transaction Effects                                                                               │
├───────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Digest: EMvKoJt5vjdgBdLEpnemdk65JbEumPgQFrmrzBgdePc9                                              │
│ Status: Success                                                                                   │
│ Executed Epoch: 1015                                                                              │
│                                                                                                   │
│ Created Objects:                                                                                  │
│  ┌──                                                                                              │
│  │ ID: 0x4ce10a38e47c322c70525977eb772418a6fb231463e8da06b1915c306bf16489                         │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )  │
│  │ Version: 760374647                                                                             │
│  │ Digest: C56K6YSvmVhZe9c876yUtDibb5SuHZBj7sK2AXYeApBT                                           │
│  └──                                                                                              │
│  ┌──                                                                                              │
│  │ ID: 0x5b6dd85447e15453db7e7cda38574f56e421bf5eecb29cb7c401d9e1b30e7ede                         │
│  │ Owner: Object ID: ( 0xe8417c530cde59eddf6dfb760e8a0e3e2c6f17c69ddaab5a73dd6a6e65fc463b )       │
│  │ Version: 760374647                                                                             │
│  │ Digest: 5v4SJJVrZxu1Kj3HGdx2WRBFR5cH5PPDDeDFnhAHbMwc                                           │
│  └──                                                                                              │
│ Mutated Objects:                                                                                  │
│  ┌──                                                                                              │
│  │ ID: 0x0e5d473a055b6b7d014af557a13ad9075157fdc19b6d51562a18511afd397727                         │
│  │ Owner: Shared( 433057694 )                                                                     │
│  │ Version: 760374647                                                                             │
│  │ Digest: 12jFD325b7xmFsGi9rs15hS2rGyuwm96Sddes64GzMhX                                           │
│  └──                                                                                              │
│  ┌──                                                                                              │
│  │ ID: 0x31c89ea3dedaddefa8ddec47e50bd3242fe385f35ac39979a91ee4074c7ad8ad                         │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )  │
│  │ Version: 760374647                                                                             │
│  │ Digest: 4bkenx2oJwucooqRWoZaY9fre9RcVE58UPwWYmne6t9P                                           │
│  └──                                                                                              │
│  ┌──                                                                                              │
│  │ ID: 0xba583898cf6f4ad7fa7d8d1d9ec205137158589237e8ce476d87d64c5a0692bb                         │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )  │
│  │ Version: 760374647                                                                             │
│  │ Digest: CiQUXAWeq1KbKwgvzKBc3Y1WZCa2B7zj2jgg1ECGFRjB                                           │
│  └──                                                                                              │
│ Shared Objects:                                                                                   │
│  ┌──                                                                                              │
│  │ ID: 0x0e5d473a055b6b7d014af557a13ad9075157fdc19b6d51562a18511afd397727                         │
│  │ Version: 759577240                                                                             │
│  │ Digest: 6KvUDHtCRf5U6wf6J4bLsfFGr5xjFnzD6ekES2Nft5X6                                           │
│  └──                                                                                              │
│  ┌──                                                                                              │
│  │ ID: 0x0000000000000000000000000000000000000000000000000000000000000006                         │
│  │ Version: 704793294                                                                             │
│  │ Digest: XjYAB82R2yB6YgrSeTJqk2yU2fNoBSPaExzW13oPXbp                                            │
│  └──                                                                                              │
│ Gas Object:                                                                                       │
│  ┌──                                                                                              │
│  │ ID: 0xba583898cf6f4ad7fa7d8d1d9ec205137158589237e8ce476d87d64c5a0692bb                         │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )  │
│  │ Version: 760374647                                                                             │
│  │ Digest: CiQUXAWeq1KbKwgvzKBc3Y1WZCa2B7zj2jgg1ECGFRjB                                           │
│  └──                                                                                              │
│ Gas Cost Summary:                                                                                 │
│    Storage Cost: 13512800 MIST                                                                    │
│    Computation Cost: 500000 MIST                                                                  │
│    Storage Rebate: 4687452 MIST                                                                   │
│    Non-refundable Storage Fee: 47348 MIST                                                         │
│                                                                                                   │
│ Transaction Dependencies:                                                                         │
│    13KGrdh6VnGmLGxzL9XZ5zhoXT5JrVU8VTbbVuMiaL7W                                                   │
│    2ebw8kyoVLnoPsQz18VPLDTqrH1W2UTHzREZctGR4skb                                                   │
│    6xw4sNCSZ1fGsABmKFnQ8tAv8x6ZQDpLAqVbFfA541df                                                   │
│    9F1bALv4ZuMpSE57eUpsoazuizYEazX413G5HzhbZJ5C                                                   │
│    9M1aj1nWCWKA5JMqTBpvkciwyMsCMzTXuK7cdjcPAshb                                                   │
│    9kF5z1HcjUktjbNwdfm7ktzQ6d83EDJBuakwjdHBTPyR                                                   │
╰───────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─────────────────────────────╮
│ No transaction block events │
╰─────────────────────────────╯

╭──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Object Changes                                                                                                                                                                                                       │
├──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┤
│ Created Objects:                                                                                                                                                                                                     │
│  ┌──                                                                                                                                                                                                                 │
│  │ ObjectID: 0x4ce10a38e47c322c70525977eb772418a6fb231463e8da06b1915c306bf16489                                                                                                                                      │
│  │ Sender: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                                                                                                                                        │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )                                                                                                                     │
│  │ ObjectType: 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppCap                                                                                                                │
│  │ Version: 760374647                                                                                                                                                                                                │
│  │ Digest: C56K6YSvmVhZe9c876yUtDibb5SuHZBj7sK2AXYeApBT                                                                                                                                                              │
│  └──                                                                                                                                                                                                                 │
│  ┌──                                                                                                                                                                                                                 │
│  │ ObjectID: 0x5b6dd85447e15453db7e7cda38574f56e421bf5eecb29cb7c401d9e1b30e7ede                                                                                                                                      │
│  │ Sender: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                                                                                                                                        │
│  │ Owner: Object ID: ( 0xe8417c530cde59eddf6dfb760e8a0e3e2c6f17c69ddaab5a73dd6a6e65fc463b )                                                                                                                          │
│  │ ObjectType: 0x2::dynamic_field::Field<0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::name::Name, 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::app_record::AppRecord>  │
│  │ Version: 760374647                                                                                                                                                                                                │
│  │ Digest: 5v4SJJVrZxu1Kj3HGdx2WRBFR5cH5PPDDeDFnhAHbMwc                                                                                                                                                              │
│  └──                                                                                                                                                                                                                 │
│ Mutated Objects:                                                                                                                                                                                                     │
│  ┌──                                                                                                                                                                                                                 │
│  │ ObjectID: 0x0e5d473a055b6b7d014af557a13ad9075157fdc19b6d51562a18511afd397727                                                                                                                                      │
│  │ Sender: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                                                                                                                                        │
│  │ Owner: Shared( 433057694 )                                                                                                                                                                                        │
│  │ ObjectType: 0x62c1f5b1cb9e3bfc3dd1f73c95066487b662048a6358eabdbf67f6cdeca6db4b::move_registry::MoveRegistry                                                                                                       │
│  │ Version: 760374647                                                                                                                                                                                                │
│  │ Digest: 12jFD325b7xmFsGi9rs15hS2rGyuwm96Sddes64GzMhX                                                                                                                                                              │
│  └──                                                                                                                                                                                                                 │
│  ┌──                                                                                                                                                                                                                 │
│  │ ObjectID: 0x31c89ea3dedaddefa8ddec47e50bd3242fe385f35ac39979a91ee4074c7ad8ad                                                                                                                                      │
│  │ Sender: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                                                                                                                                        │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )                                                                                                                     │
│  │ ObjectType: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration                                                                                             │
│  │ Version: 760374647                                                                                                                                                                                                │
│  │ Digest: 4bkenx2oJwucooqRWoZaY9fre9RcVE58UPwWYmne6t9P                                                                                                                                                              │
│  └──                                                                                                                                                                                                                 │
│  ┌──                                                                                                                                                                                                                 │
│  │ ObjectID: 0xba583898cf6f4ad7fa7d8d1d9ec205137158589237e8ce476d87d64c5a0692bb                                                                                                                                      │
│  │ Sender: 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1                                                                                                                                        │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )                                                                                                                     │
│  │ ObjectType: 0x2::coin::Coin<0x2::sui::SUI>                                                                                                                                                                        │
│  │ Version: 760374647                                                                                                                                                                                                │
│  │ Digest: CiQUXAWeq1KbKwgvzKBc3Y1WZCa2B7zj2jgg1ECGFRjB                                                                                                                                                              │
│  └──                                                                                                                                                                                                                 │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭───────────────────────────────────────────────────────────────────────────────────────────────────╮
│ Balance Changes                                                                                   │
├───────────────────────────────────────────────────────────────────────────────────────────────────┤
│  ┌──                                                                                              │
│  │ Owner: Account Address ( 0x83016091e446ca1c0c27b44c83770eea32f6509e7c84c6aabad56394d35fe8f1 )  │
│  │ CoinType: 0x2::sui::SUI                                                                        │
│  │ Amount: -9325348                                                                               │
│  └──                                                                                              │
╰───────────────────────────────────────────────────────────────────────────────────────────────────╯
```

#### Step 3: Verify registration

After registration, your package can be resolved using:
```bash
sui client switch --env testnet
mvr resolve @iota-a/ascii-vec
```

Or use it as a dependency in other Move projects:
```bash
mvr add @iota-a/ascii-vec
```

#### References
- [MVR Documentation](https://docs.suins.io/move-registry)
- [Managing Package Metadata](https://docs.suins.io/move-registry/managing-package-info)
- [Managing MVR Names](https://docs.suins.io/move-registry/mvr-names)
- [MVR Web App](https://www.moveregistry.com/apps)


#### Finally call is_ascii_vec() with ptb dev inspector to test your package!
```bash
sui client ptb \
--move-call @potatoes/ascii::ascii::is_ascii '"IOTA"' \
--dev-inspect
sui client ptb \
--move-call @iota-a/ascii-vec::ascii_vec::is_ascii_vec '"["A", "B", "C"]"' \
--dev-inspect
```


### Example data:
panos:
PackageInfo: https://suiscan.xyz/testnet/object/0x058e1cbf1c202391b6ebb36eea9111c3fd26ffa5f5c76c4608023a8d3d9f1357/fields
AppRecord: https://suiscan.xyz/mainnet/object/0xcf3069a859cf64ee481c9317de33701a47da453fe11a04d6bbc4fea6e9b41135/fields
AppCap: https://suiscan.xyz/mainnet/object/0xa08f973034458f870b951b36f67894ec88d435e55d4d9789c549c8db3861a9db/fields

MoveRegistry working: https://www.moveregistry.com/package/@panosui/pkg

ascii_vec:
PackageInfo: https://suiscan.xyz/testnet/object/0x3c754c8358191d0f5333c52dccc9148b757b347928ed6025472be4dfe0a16290/tx-blocks
AppCap: https://suiscan.xyz/mainnet/object/0x4ce10a38e47c322c70525977eb772418a6fb231463e8da06b1915c306bf16489/fields
AppRecord: https://suiscan.xyz/mainnet/object/0x5b6dd85447e15453db7e7cda38574f56e421bf5eecb29cb7c401d9e1b30e7ede/fields

MoveRegistry not working, but showing in the search with "iot-a": https://www.moveregistry.com/package/@iota-a/ascii-vec

# Commands to check the JSON data of the objects (panos):
sui client switch --env mainnet
sui client object 0xcf3069a859cf64ee481c9317de33701a47da453fe11a04d6bbc4fea6e9b41135 --json
sui client object 0xa08f973034458f870b951b36f67894ec88d435e55d4d9789c549c8db3861a9db --json
sui client switch --env testnet
sui client object 0x058e1cbf1c202391b6ebb36eea9111c3fd26ffa5f5c76c4608023a8d3d9f1357 --json

# Commands to check the JSON data of the objects (ascii_vec):
sui client switch --env mainnet
sui client object 0x4ce10a38e47c322c70525977eb772418a6fb231463e8da06b1915c306bf16489 --json
sui client object 0x5b6dd85447e15453db7e7cda38574f56e421bf5eecb29cb7c401d9e1b30e7ede --json
sui client switch --env testnet
sui client object 0x3c754c8358191d0f5333c52dccc9148b757b347928ed6025472be4dfe0a16290 --json


curl -s https://testnet.mvr.mystenlabs.com/v1/names/@panosui/pkg | jq

curl -s https://testnet.mvr.mystenlabs.com/v1/names/@iota-a/ascii-vec | jq

curl -s https://mainnet.mvr.mystenlabs.com/v1/names\?search\=ascii\&limit\=20\&is_linked\=true | jq
{
  "data": [
    {
      "name": "@iota-a/ascii-vec",
      "metadata": {
        "description": "ASCII vector utilities for Move"
      },
      "mainnet_package_info_id": null,
      "testnet_package_info_id": "0x3c754c8358191d0f5333c52dccc9148b757b347928ed6025472be4dfe0a16290"
    },
    {
      "name": "@potatoes/ascii",
      "metadata": {
        "contact": "https://github.com/sui-potatoes",
        "icon_url": "https://raw.githubusercontent.com/sui-potatoes/app/main/packages/ascii/icon.png",
        "description": "0-cost ASCII table: control, printable and extended set; and a collection of common utilities",
        "homepage_url": "https://potatoes.app/",
        "documentation_url": "https://github.com/sui-potatoes/app/tree/ascii%40v1/packages/ascii/docs"
      },
      "mainnet_package_info_id": "0xc18a0e17cba2ce311a80cec68dbd45ebaa67bb3e4e6f361bdeae30268e33dcbf",
      "testnet_package_info_id": "0x0bd7e3b8444c47fca67fd7f8c258775495855142e85cbcc64c266a6c253a2b56"
    }
  ],
  "next_cursor": null,
  "limit": 20,
  "total": null
}
