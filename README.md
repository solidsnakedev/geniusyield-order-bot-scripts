# geniusyield-order-bot-scripts

## Requirements
Make sure to install docker before proceeding
https://docs.docker.com/desktop/install/linux-install

## Create a folder
```
mkdir order-bot
cd order-bot
```

## Download latest cardano-cli

```
curl -s  https://raw.githubusercontent.com/solidsnakedev/geniusyield-order-bot-scripts/main/download-cardano-cli.sh | bash
```

## make cardano-cli executable

```
chmod +x cardano-cli
```

## Generate bot keys

```
./cardano-cli address key-gen \
	--verification-key-file bot.vkey \
	--signing-key-file bot.skey
```

```
./cardano-cli address build \
    --payment-verification-key-file bot.vkey \
    --testnet-magic 1 \
    --out-file bot.preprod.addr
```

## Fund wallet bot address

```
cat bot.preprod.addr
```

## Get signing key

```
cat bot.skey | jq .cborHex
```

## Option 1. Create a `.env.local` file using maestro

```
PAYMENT_SIGNING_KEY_CBOR_HEX=your-signing-key
MAESTRO_API_KEY=your-preprod-api-key
CARDANO_NETWORK=testnet-preprod
```

## Option 2. Create a `.env.local` file using blockfrost

```
PAYMENT_SIGNING_KEY_CBOR_HEX=your-signing-key
BLOCKFROST_API_KEY=your-preprod-api-key
CARDANO_NETWORK=testnet-preprod
```

## Set optional collateral

```
COLLATERAL_UTXO_REF=7cc7b044d26981d3fc73ae72994f289d99ba113ceefb5b83f4d7643bfb12682a#1
```

## Run order bot

```
curl -s https://raw.githubusercontent.com/solidsnakedev/geniusyield-order-bot-scripts/main/run-order-bot.sh | bash
```
