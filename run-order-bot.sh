#!/bin/bash
source .env.local
printf "Loading .env.local\n\n"
cat .env.local

printf "\nRunning geniusyield order bot:\n"
if [ -z ${COLLATERAL_UTXO_REF} ]; then
    if [ ! -z ${BLOCKFROST_API_KEY} ]; then
        printf "BLOCKFROST_API_KEY is set, using blockfrost\n"
        docker run -d \
            --name geniusyield-order-bot \
            -e BOTC_SKEY="{\"cborHex\": \"$PAYMENT_SIGNING_KEY_CBOR_HEX\", \"type\": \"PaymentSigningKeyShelley_ed25519\", \"description\": \"Payment Signing Key\"}" \
            -e BOTC_CONFIG="{ \"coreProvider\": { \"blockfrostKey\": \"$BLOCKFROST_API_KEY\" }, \"networkId\": \"$CARDANO_NETWORK\", \"logging\": [{ \"type\": { \"tag\": \"stderr\" }, \"severity\": \"Info\", \"verbosity\": \"V2\" }],\"utxoCacheEnable\": false }" \
            ghcr.io/geniusyield/smart-order-router:latest
    elif [ ! -z ${MAESTRO_API_KEY} ]; then
        printf "MAESTRO_API_KEY is set, using maestro\n"
        docker run -d \
            --name geniusyield-order-bot \
            -e BOTC_SKEY="{\"cborHex\": \"$PAYMENT_SIGNING_KEY_CBOR_HEX\", \"type\": \"PaymentSigningKeyShelley_ed25519\", \"description\": \"Payment Signing Key\"}" \
            -e BOTC_CONFIG="{ \"coreProvider\": { \"maestroToken\": \"$MAESTRO_API_KEY\" }, \"networkId\": \"$CARDANO_NETWORK\", \"logging\": [{ \"type\": { \"tag\": \"stderr\" }, \"severity\": \"Info\", \"verbosity\": \"V2\" }],\"utxoCacheEnable\": false }" \
            ghcr.io/geniusyield/smart-order-router:latest
    else
        printf "missing BLOCKFROST_API_KEY or MAESTRO_API_KEY"
        exit 1
    fi

else
    if [ ! -z ${BLOCKFROST_API_KEY} ]; then
        printf "BLOCKFROST_API_KEY is set, using blockfrost\n"
        docker run -d \
            --name geniusyield-order-bot \
            -e BOTC_SKEY="{\"cborHex\": \"$PAYMENT_SIGNING_KEY_CBOR_HEX\", \"type\": \"PaymentSigningKeyShelley_ed25519\", \"description\": \"Payment Signing Key\"}" \
            -e BOTC_COLLATERAL="$COLLATERAL_UTXO_REF" \
            -e BOTC_CONFIG="{ \"coreProvider\": { \"blockfrostKey\": \"$BLOCKFROST_API_KEY\" }, \"networkId\": \"$CARDANO_NETWORK\", \"logging\": [{ \"type\": { \"tag\": \"stderr\" }, \"severity\": \"Info\", \"verbosity\": \"V2\" }],\"utxoCacheEnable\": false }" \
            ghcr.io/geniusyield/smart-order-router:latest
    elif [ ! -z ${MAESTRO_API_KEY} ]; then
        printf "MAESTRO_API_KEY is set, using maestro\n"
        docker run -d \
            --name geniusyield-order-bot \
            -e BOTC_SKEY="{\"cborHex\": \"$PAYMENT_SIGNING_KEY_CBOR_HEX\", \"type\": \"PaymentSigningKeyShelley_ed25519\", \"description\": \"Payment Signing Key\"}" \
            -e BOTC_COLLATERAL="$COLLATERAL_UTXO_REF" \
            -e BOTC_CONFIG="{ \"coreProvider\": { \"maestroToken\": \"$MAESTRO_API_KEY\" }, \"networkId\": \"$CARDANO_NETWORK\", \"logging\": [{ \"type\": { \"tag\": \"stderr\" }, \"severity\": \"Info\", \"verbosity\": \"V2\" }],\"utxoCacheEnable\": false }" \
            ghcr.io/geniusyield/smart-order-router:latest
    else
        printf "missing BLOCKFROST_API_KEY or MAESTRO_API_KEY"
        exit 1
    fi
fi
