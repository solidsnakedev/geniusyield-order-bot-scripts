#!/bin/bash
source .env.local
printf "Loading .env.local\n\n"

printf "PAYMENT_SIGNING_KEY_CBOR_HEX=${PAYMENT_SIGNING_KEY_CBOR_HEX:?"missing variable"}\n"
printf "CARDANO_NETWORK=${CARDANO_NETWORK:?"missing variable"}\n"

printf "Running geniusyield order bot: \n"
if [ -z ${COLLATERAL_UTXO_REF} ]; then
    if [ -n ${BLOCKFROST_API_KEY} ]; then
        docker run -d \
            --name geniusyield-order-bot \
            -e BOTC_SKEY="{\"cborHex\": \"$PAYMENT_SIGNING_KEY_CBOR_HEX\", \"type\": \"PaymentSigningKeyShelley_ed25519\", \"description\": \"Payment Signing Key\"}" \
            -e BOTC_CONFIG="{ \"coreProvider\": { \"blockfrostKey\": \"$BLOCKFROST_API_KEY\" }, \"networkId\": \"$CARDANO_NETWORK\", \"logging\": [{ \"type\": { \"tag\": \"stderr\" }, \"severity\": \"Info\", \"verbosity\": \"V2\" }],\"utxoCacheEnable\": false }" \
            ghcr.io/geniusyield/smart-order-router:latest
    elif [ -n ${MAESTRO_API_KEY} ]; then
        docker run -d \
            -e BOTC_SKEY="{\"cborHex\": \"$PAYMENT_SIGNING_KEY_CBOR_HEX\", \"type\": \"PaymentSigningKeyShelley_ed25519\", \"description\": \"Payment Signing Key\"}" \
            -e BOTC_CONFIG="{ \"coreProvider\": { \"maestroToken\": \"$MAESTRO_API_KEY\" }, \"networkId\": \"$CARDANO_NETWORK\", \"logging\": [{ \"type\": { \"tag\": \"stderr\" }, \"severity\": \"Info\", \"verbosity\": \"V2\" }],\"utxoCacheEnable\": false }" \
            ghcr.io/geniusyield/smart-order-router:latest
    else
        printf "missing BLOCKFROST_API_KEY or MAESTRO_API_KEY"
        exit 1
    fi

else
    if [ -n ${BLOCKFROST_API_KEY} ]; then
        docker run -d \
            --name geniusyield-order-bot \
            -e BOTC_SKEY="{\"cborHex\": \"$PAYMENT_SIGNING_KEY_CBOR_HEX\", \"type\": \"PaymentSigningKeyShelley_ed25519\", \"description\": \"Payment Signing Key\"}" \
            -e BOTC_COLLATERAL="$COLLATERAL_UTXO_REF" \
            -e BOTC_CONFIG="{ \"coreProvider\": { \"blockfrostKey\": \"$BLOCKFROST_API_KEY\" }, \"networkId\": \"$CARDANO_NETWORK\", \"logging\": [{ \"type\": { \"tag\": \"stderr\" }, \"severity\": \"Info\", \"verbosity\": \"V2\" }],\"utxoCacheEnable\": false }" \
            ghcr.io/geniusyield/smart-order-router:latest
    elif [ -n ${MAESTRO_API_KEY} ]; then
        docker run -d \
            -e BOTC_SKEY="{\"cborHex\": \"$PAYMENT_SIGNING_KEY_CBOR_HEX\", \"type\": \"PaymentSigningKeyShelley_ed25519\", \"description\": \"Payment Signing Key\"}" \
            -e BOTC_COLLATERAL="$COLLATERAL_UTXO_REF" \
            -e BOTC_CONFIG="{ \"coreProvider\": { \"maestroToken\": \"$MAESTRO_API_KEY\" }, \"networkId\": \"$CARDANO_NETWORK\", \"logging\": [{ \"type\": { \"tag\": \"stderr\" }, \"severity\": \"Info\", \"verbosity\": \"V2\" }],\"utxoCacheEnable\": false }" \
            ghcr.io/geniusyield/smart-order-router:latest
    else
        printf "missing BLOCKFROST_API_KEY or MAESTRO_API_KEY"
        exit 1
    fi
fi
