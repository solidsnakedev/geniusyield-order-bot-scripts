URL=$(curl -s https://api.github.com/repos/input-output-hk/cardano-node/releases/latest | jq -r '.assets[] | select(.name | contains("linux")) | .browser_download_url')
echo $URL
wget -cO - ${URL} > cardano-node.tar.gz
tar -xvf cardano-node.tar.gz ./cardano-cli