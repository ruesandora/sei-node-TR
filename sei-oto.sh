#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
echo ''
else
  sudo apt update && sudo apt install curl -y < "/dev/null"
fi
bash_profile=$HOME/.bash_profile
if [ -f "$bash_profile" ]; then
    . $HOME/.bash_profile
fi
sleep 1 && curl -s https://databox.acadao.org/logo.sh | bash && sleep 1


if [ ! $SEID_NODENAME ]; then
read -p "Node ismi girin: " SEID_NODENAME
echo 'export SEID_NODENAME='\"${SEID_NODENAME}\" >> $HOME/.bash_profile
fi
echo 'source $HOME/.bashrc' >> $HOME/.bash_profile
. $HOME/.bash_profile
sleep 1
cd $HOME
sudo apt update
sudo apt install make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils htop -y < "/dev/null"

echo -e '\n\e[42mGo Kurulumu\e[0m\n' && sleep 1
cd $HOME
wget -O go1.18.1.linux-amd64.tar.gz https://golang.org/dl/go1.18.1.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.1.linux-amd64.tar.gz && rm go1.18.1.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile
go version

echo -e '\n\e[42mSEI Kurulumu\e[0m\n' && sleep 1
rm -rf $HOME/sei-chain
git clone --depth 1 --branch 1.0.2beta https://github.com/sei-protocol/sei-chain.git
cd $HOME/sei-chain
make install
sleep 1
ln -s $HOME/go/bin/seid /usr/local/bin/seid
kujirad init "$SEID_NODENAME" --chain-id=sei-testnet-2

echo -e '\n\e[42mSeed Bilgileri ekleniyor\e[0m\n' && sleep 1

# Seed ayarlanması
SEEDS=""
PEERS="585727dac5df8f8662a8ff42052a9584a1f7ee95@165.22.25.77:26656,2f047e234cb8b99fe8b9fee0059a5bc45042bc97@95.216.84.188:26656,bab4849cf3918c37b04cd3714984d1765616a4b2@49.12.76.255:36656,ab955dc7f70d8613ab4b554868d4658fd70b797b@217.79.180.194:26656,39c4bcaded0d1d886f2788ae955f1939406f3e7d@65.108.198.54:26696,9db58dba3b6354177fb428caccf5167c616ad4a1@167.235.28.18:26656,2f2804434afda302c86eb89eca27503e49a8a260@65.21.131.215:26696,38b4d78c7d6582fb170f6c19330a7e37e6964212@194.163.189.114:46656,7c5ee0d66a15013f0a771055378c5316331f17ba@95.216.101.84:25646,6f71bcbe347069fc4df9b607f6b843226e8deb71@95.217.221.201:26656"
sed -i -e "s/^seeds *=.*/seeds = \"$SEEDS\"/; s/^persistent_peers *=.*/persistent_peers = \"$PEERS\"/" $HOME/.sei/config/config.toml



#### VALIDATOR ####
sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.sei/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.sei/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.sei/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.sei/config/app.toml
seid tendermint unsafe-reset-all
echo -e '\n\e[42mServis Kuruluyor\e[0m\n' && sleep 1

# servis
tee $HOME/seid.service > /dev/null <<EOF
[Unit]
Description=seid
After=network.target
[Service]
Type=simple
User=$USER
ExecStart=$(which seid) start
Restart=on-failure
RestartSec=10
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF

sudo mv $HOME/seid.service /etc/systemd/system/


echo -e '\n\e[42mRunning a service\e[0m\n' && sleep 1
sudo systemctl daemon-reload
sudo systemctl enable seid
sudo systemctl restart seid


echo -e '\n\e[42mCheck node status\e[0m\n' && sleep 1
if [[ `service seid status | grep active` =~ "running" ]]; then
  echo -e "sei node \e[32kuruldu ve ok\e[39m!"
  echo -e "Press \e[7mQ\e[0m for exit from status menu"
else
  echo -e "sei node \e[31mbir hata var\e[39m, tekrar kur."
fi
