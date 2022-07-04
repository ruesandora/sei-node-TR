<h1 align="center">Sei Validatör Script Kurulum</h1>

# Sei Network validatör kurulum rehberine hoş geldiniz.

Sorularınız ve sorunlarınız için telegram kanalı: [Telegram](https://t.me/SeiNetworkTurkish)

![image](https://user-images.githubusercontent.com/101149671/172654026-36c4b404-4220-4eba-9331-c40cd3a13acc.png)


Sei Ağı, sipariş defterine özgü ilk L1 blok zinciridir. Zincir, her şeyden önce güvenilirliği, güvenliği ve yüksek verimi vurgulayarak, üstüne inşa edilmiş ultra yüksek performanslı DeFı ürünlerinin tamamen yeni bir kademesini mümkün kılıyor. Sei'nin zincir içi CLOB ve eşleştirme motoru, tüccarlar ve uygulamalar için derin likidite ve fiyat-zaman öncelikli eşleştirme sağlar. Seı üzerine kurulu uygulamalar, yerleşik sipariş defteri altyapısından, derin likiditeden ve tamamen merkezi olmayan bir eşleştirme hizmetinden yararlanır. Kullanıcılar, MEV koruması ile birlikte işlemlerinin fiyatını, boyutunu ve yönünü seçme yeteneği ile bu değişim modelinden yararlanır.

!Ruesandora tarafından Oluşturulmuştur.
# Validator Node Gereksinimleri 

Sistem Gereksinimleri : 

|    Bellek   |       Cpu      |      Disk      |   Ağ           |
|-------------|----------------|----------------|----------------|
|     4GB     |   Quad-Core    |     250GB      |  1Gbps/100Mbps |

Yazılım Gereksinimleri : 

| Gereksinim  | Not            | İşletim Sistemi |
|-------------|----------------|-----------------|
| Go Sürümü   | 1.17+          | Ubuntu 20.04    |

# Oto Kurulum

Öncelikle Sunucumuza baglanalım, bir pencere açalım ve işlemlere başlayalım.

```sh
  #Screen Kuralım
  apt install screen
  #Yeni bir screen açalım
  screen -S node
  #Oto kurulumu başlatalım
  wget -q -O sei-kur.sh https://api.rues.info/sei-kur.sh && chmod +x sei-kur.sh && sudo /bin/bash sei-kur.sh
  #Node ismi isteycektir girin ve Enter basın işlemin bitmesini bekleyin
```

Şuan Node'unuz kuruldu ve Servis dosyası oluştu. Node Pencerisi içine Node Loglarımızı açalım.
```sh
 journalctl -u seid -f
```
CTRL + A + D ile pencerimizi kapatalım.
Eşleşme Tamamlandıktan sonra validatör açmanız gerek...
```sh
 screen -S validator
 #"<wallet-ismi>" degiştirin ve cüzdan oluşturun
 seid keys add <wallet-ismi>
 
 #Oluşan Cüzdan kayıt edin ve Token alın. "<wallet-ismi>" degiştirin.
 
 PUBKEY=$(seid tendermint show-validator)
 seid tx staking create-validator \
    --amount=1000000usei \
    --pubkey=$PUBKEY \
    --moniker=$MONIKER \
    --chain-id=sei-testnet-2 \
    --from=<wallet-ismi> \
    --commission-rate="0.10" \
    --commission-max-rate="0.20" \
    --commission-max-change-rate="0.01" \
    --min-self-delegation="1" \
    --yes
 #"CTRL + A + D" screen kapatın.
```

# 1.0.3b Güncellemesi

Node Pencerinize girin, "systemctl stop seid" ile durdurun. 
Güncellemeye devam edin..

```sh
 Update 1.0.3b

//oto kurulum için
cd
rm $HOME/sei -rf
git clone https://github.com/sei-protocol/sei-chain.git && cd $HOME/sei-chain
git checkout 1.0.3beta
make install
go build -o build/seid ./cmd/seid
chmod +x ./build/seid && sudo mv ./build/seid /usr/local/bin/seid
mv ~/go/bin/seid /usr/local/bin/seid
mv $HOME/sei-chain $HOME/sei
systemctl restart seid
journalctl -fu seid -o cat

//manuel kurulum için
cd
rm $HOME/sei-chain -rf
git clone https://github.com/sei-protocol/sei-chain.git && cd $HOME/sei-chain
git checkout 1.0.3beta
make install
go build -o build/seid ./cmd/seid
chmod +x ./build/seid && sudo mv ./build/seid /usr/local/bin/seid
mv ~/go/bin/seid /usr/local/bin/seid
systemctl restart seid
journalctl -fu seid -o cat
```

# 1.0.4b Güncellemesi

```
//oto kurulum için
cd
rm $HOME/sei -rf
git clone https://github.com/sei-protocol/sei-chain.git && cd $HOME/sei-chain
git checkout 1.0.4beta
make install
go build -o build/seid ./cmd/seid
chmod +x ./build/seid && sudo mv ./build/seid /usr/local/bin/seid
mv ~/go/bin/seid /usr/local/bin/seid
mv $HOME/sei-chain $HOME/sei
systemctl restart seid
journalctl -fu seid -o cat

//manuel kurulum için
cd
rm $HOME/sei-chain -rf
git clone https://github.com/sei-protocol/sei-chain.git && cd $HOME/sei-chain
git checkout 1.0.4beta
make install
go build -o build/seid ./cmd/seid
chmod +x ./build/seid && sudo mv ./build/seid /usr/local/bin/seid
mv ~/go/bin/seid /usr/local/bin/seid
systemctl restart seid
journalctl -fu seid -o cat
```

# 1.0.5b Güncellemesi

```
//oto kurulum için
cd
rm $HOME/sei -rf
git clone https://github.com/sei-protocol/sei-chain.git && cd $HOME/sei-chain
git checkout 1.0.5beta
make install
go build -o build/seid ./cmd/seid
chmod +x ./build/seid && sudo mv ./build/seid /usr/local/bin/seid
mv ~/go/bin/seid /usr/local/bin/seid
mv $HOME/sei-chain $HOME/sei
systemctl restart seid
journalctl -fu seid -o cat

//manuel kurulum için
cd
rm $HOME/sei-chain -rf
git clone https://github.com/sei-protocol/sei-chain.git && cd $HOME/sei-chain
git checkout 1.0.5beta
make install
go build -o build/seid ./cmd/seid
chmod +x ./build/seid && sudo mv ./build/seid /usr/local/bin/seid
mv ~/go/bin/seid /usr/local/bin/seid
systemctl restart seid
journalctl -fu seid -o cat
```

# 1.0.6b Güncellemesi
```
//oto kurulum için
cd
rm $HOME/sei -rf
git clone https://github.com/sei-protocol/sei-chain.git && cd $HOME/sei-chain
git checkout 1.0.6beta
make install
go build -o build/seid ./cmd/seid
chmod +x ./build/seid && sudo mv ./build/seid /usr/local/bin/seid
mv ~/go/bin/seid /usr/local/bin/seid
mv $HOME/sei-chain $HOME/sei
systemctl restart seid
journalctl -fu seid -o cat

//manuel kurulum için
cd
rm $HOME/sei-chain -rf
git clone https://github.com/sei-protocol/sei-chain.git && cd $HOME/sei-chain
git checkout 1.0.6beta
make install
go build -o build/seid ./cmd/seid
chmod +x ./build/seid && sudo mv ./build/seid /usr/local/bin/seid
mv ~/go/bin/seid /usr/local/bin/seid
systemctl restart seid
journalctl -fu seid -o cat
```


//UnJail
seid tx slashing unjail   --broadcast-mode=block   --from=wallet chain-id=sei-testnet-2
```

# DAHA FAZLA SORUNUZ VARSA SEİ TÜRKİYE TELEGRAM GRUBU:

[Telegram](https://t.me/SeiNetworkTurkish)

Teşekkürler <3


# Hesaplar:

[<img src="https://cdn-icons-png.flaticon.com/512/733/733579.png" width="16px"> Twitter   ](https://twitter.com/Ruesandora0) 
[<img src="https://cdn-icons-png.flaticon.com/512/1336/1336494.png" width="16px"> Forum   ](https://forum.rues.info/index.php)
[<img src="https://cdn-icons-png.flaticon.com/512/2111/2111646.png" width="16px"> Telegram Announcement   ](https://t.me/RuesAnnouncement)
[<img src="https://cdn-icons-png.flaticon.com/512/2111/2111646.png" width="16px"> Telegram Chat   ](https://t.me/RuesChat)
[<img src="https://cdn-icons-png.flaticon.com/512/2111/2111646.png" width="16px"> Telegram Node   ](https://t.me/RuesNode)
[<img src="https://cdn-icons-png.flaticon.com/512/2111/2111646.png" width="16px"> Telegram Node Chat](https://t.me/RuesNodeChat)

