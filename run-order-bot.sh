printf "Running geniusyield order bot: \n"
printf "PAYMENT_SIGNING_KEY_CBOR_HEX=${PAYMENT_SIGNING_KEY_CBOR_HEX:?"missing variable"}\n"
# printf "COLLATERAL_UTXO_REF=${COLLATERAL_UTXO_REF:?"missing variable"}\n"
printf "BLOCKFROST_API_KEY=${BLOCKFROST_API_KEY:?"missing variable"}\n"
printf "CARDANO_NETWORK=${CARDANO_NETWORK:?"missing variable"}\n"

if [ -z ${COLLATERAL_UTXO_REF} ]; then
    printf "\nrunning without COLLATERAL_UTXO_REF \n\n"
    docker run -d \
        --name geniusyield-order-bot \
        -e BOTC_SKEY="{\"cborHex\": \"$PAYMENT_SIGNING_KEY_CBOR_HEX\", \"type\": \"PaymentSigningKeyShelley_ed25519\", \"description\": \"Payment Signing Key\"}" \
        -e BOTC_CONFIG="{ \"coreProvider\": { \"blockfrostKey\": \"$BLOCKFROST_API_KEY\" }, \"networkId\": \"$CARDANO_NETWORK\", \"logging\": [{ \"type\": { \"tag\": \"stderr\" }, \"severity\": \"Info\", \"verbosity\": \"V2\" }],\"utxoCacheEnable\": false }" \
        ghcr.io/geniusyield/smart-order-router:latest

else
    printf "\nrunning with COLLATERAL_UTXO_REF \n\n"
    docker run -d \
        --name geniusyield-order-bot \
        -e BOTC_SKEY="{\"cborHex\": \"$PAYMENT_SIGNING_KEY_CBOR_HEX\", \"type\": \"PaymentSigningKeyShelley_ed25519\", \"description\": \"Payment Signing Key\"}" \
        -e BOTC_COLLATERAL="$COLLATERAL_UTXO_REF" \
        -e BOTC_CONFIG="{ \"coreProvider\": { \"blockfrostKey\": \"$BLOCKFROST_API_KEY\" }, \"networkId\": \"$CARDANO_NETWORK\", \"logging\": [{ \"type\": { \"tag\": \"stderr\" }, \"severity\": \"Info\", \"verbosity\": \"V2\" }],\"utxoCacheEnable\": false }" \
        ghcr.io/geniusyield/smart-order-router:latest
fi
