# geniusyield-order-bot-scripts

## Download cardano-cli

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

./cardano-cli address build \
    --payment-verification-key-file bot.vkey \
    --testnet-magic 1 \
    --out-file bot.preprod.addr
```

# SMART ORDER ROUTER INSTANCE USING BLOCKFROST

## Replace these values with your configuration:

```
export PAYMENT_SIGNING_KEY_CBOR_HEX=5820d682e237a04d43ad011fdecd141acd485f6d3d634466692d58f6d75250f39134
export COLLATERAL_UTXO_REF=7cc7b044d26981d3fc73ae72994f289d99ba113ceefb5b83f4d7643bfb12682a#1
export BLOCKFROST_API_KEY=some_api_key
export CARDANO_NETWORK=testnet-preprod
```

## Run order bot

```
curl -s https://raw.githubusercontent.com/solidsnakedev/geniusyield-order-bot-scripts/main/run-order-bot.sh | bash
```
