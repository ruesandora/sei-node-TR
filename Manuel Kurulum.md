<h1 align="center">Sei Validatör Kurulumu Manuel</h1>

# Sei Network validatör kurulum rehberine hoş geldiniz.
Manuel kurulum rehberi, script ile daha rahat kurabilirsiniz.
Sorularınız ve sorunlarınız için telegram kanalı: [Telegram](https://t.me/SeiNetworkTurkish)

![image](https://user-images.githubusercontent.com/101149671/172654026-36c4b404-4220-4eba-9331-c40cd3a13acc.png)

# Makinemizi güncelliyoruz:

```
sudo apt-get update && apt-get upgrade -y
```

# Gerekli araçların yüklemesini yapıyoruz:
```
sudo apt install make clang pkg-config libssl-dev build-essential git jq ncdu bsdmainutils htop -y < "/dev/null"
```
# Go kurulumumuzu yapıyoruz:
```
wget -O go1.18.1.linux-amd64.tar.gz https://golang.org/dl/go1.18.1.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.18.1.linux-amd64.tar.gz && rm go1.18.1.linux-amd64.tar.gz
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile && . $HOME/.bash_profile
go version
```

# Githubtan dosyaları indiriyoruz:
```
git clone --depth 1 --branch 1.0.2beta https://github.com/sei-protocol/sei-chain.git
```

# sei-chain dosyasına girerek kurulum yapıyoruz.
```
cd sei-chain/
make install
```

# Moniker name giriyoruz. Tırnak arasındaki YOUR_MONKER kısmına kendi ismimizi giriyoruz:
```
export MONIKER="YOUR_MONIKER"
```

# Moniker init ediyoruz:
```
seid init $MONIKER --chain-id sei-testnet-2 -o
```
# Genesis dosyasını indiriyoruz:
```
wget -qO $HOME/.sei/config/genesis.json "https://raw.githubusercontent.com/sei-protocol/testnet/main/sei-testnet-2/genesis.json"
```
# Addrbook.json dosyasını indiriyoruz:
```
wget -qO $HOME/.sei/config/addrbook.json "https://raw.githubusercontent.com/sei-protocol/testnet/main/sei-testnet-2/addrbook.json"
```
# Screen aracımızın kurulumunu yapıyoruz: 
```
apt-get install screen
```
# screen oturumu açıyoruz:
```
screen -S sei
```
# screen içinde node'u başlatıyoruz.
```
seid start
```
# node durumuna bakmak için:
```
seid status
```
# Pruning yapıyoruz:
```
pruning="custom"
pruning_keep_recent="100"
pruning_keep_every="0"
pruning_interval="10"

sed -i -e "s/^pruning *=.*/pruning = \"$pruning\"/" $HOME/.sei/config/app.toml
sed -i -e "s/^pruning-keep-recent *=.*/pruning-keep-recent = \"$pruning_keep_recent\"/" $HOME/.sei/config/app.toml
sed -i -e "s/^pruning-keep-every *=.*/pruning-keep-every = \"$pruning_keep_every\"/" $HOME/.sei/config/app.toml
sed -i -e "s/^pruning-interval *=.*/pruning-interval = \"$pruning_interval\"/" $HOME/.sei/config/app.toml
```
# servis dosyamızı oluşturuyoruz: 
```
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
[/CODE]
```
# Systemctl tekrar yüklüyoruz:
```
sudo systemctl daemon-reload
```
# Servisimizi aktifleştiriyoruz:
```
sudo systemctl enable seid
```
# Son olarak servisimizi başlatıyoruz:
```
sudo systemctl start seid
```
# Servisimizin durumuna bakmak için:
```
systemctl status seid
```
# Cüzdan oluşturuyoruz. oluşan tüm cüzdan bilgilerini not ediyoruz:
```
seid keys add wallet_Name
```
# Discord grubuna girip faucet kanalından token talep ediyoruz: 
```
https://discord.gg/BFrveY5t
```
Not: Şu an faucet çalışmıyor, çalıştığı zaman deneyin.

# Validator oluşturuyoruz. cüzdan_adı kısmına kendi yukarıda belirttiğimiz cüzdan adını yazıyoruz.
```
PUBKEY=$(seid tendermint show-validator)
seid tx staking create-validator \
--amount=1000000usei \
--pubkey=$PUBKEY \
--moniker=$MONIKER \
--chain-id=$CHAIN_ID \
--from=cüzdan_adı \
--commission-rate="0.10" \
--commission-max-rate="0.20" \
--commission-max-change-rate="0.01" \
--min-self-delegation="1"
```
# Exproler:
https://sei.explorers.guru/

# DAHA FAZLA SORUNUZ VARSA SEİ TÜRKİYE TELEGRAM GRUBU:

[Telegram](https://t.me/SeiNetworkTurkish)

Teşekkürler <3


# Hesaplar:

[Twitter](https://twitter.com/Ruesandora0)

[Forum](https://forum.rues.info/index.php)

[Telegram Announcement](https://t.me/RuesAnnouncement)

[Telegram Chat](https://t.me/RuesChat)

[Telegram Node](https://t.me/RuesNode)

[Telegram Node Chat](https://t.me/RuesNodeChat)
