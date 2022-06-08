<p align="center">
  <img  src="https://cdn.discordapp.com/attachments/954773992345055262/984090832678309928/unknown.png">
</p>

<h1 align="center">Sei Chain</h1>


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
  screen -R node
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
 "CTRL + A + D" screen kapatın.
```
