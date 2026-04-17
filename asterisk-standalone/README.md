# Asterisk Standalone SIP Server

Bu dizin, `sip-gateway` içindeki diğer bileşenlerden bağımsız çalışan bir Asterisk SIP server kurar.
Kamailio/RTPEngine gerektirmez.

## İçerik

- Tek Asterisk container (`UDP/TCP 5080`, `RTP UDP 30000-40000`)
- Hızlı test için iki SIP extension (`1000` ve `1001`, `.env` ile değiştirilebilir)
- Opsiyonel `sip-debug` helper container (profile: `helpers`)

## 1) Kurulum

```bash
cd asterisk-standalone
cp .env.example .env
# .env dosyasını düzenleyin
docker compose --env-file .env up -d --build
```

Alternatif:

```bash
chmod +x start.sh
./start.sh
```

## 2) Portlar

| Protokol | Port(lar) | Amaç |
|----------|-----------|------|
| UDP/TCP | 5080 | SIP signaling |
| UDP | 30000-40000 | RTP media |

NAT/router arkasındaysanız bu portları Asterisk host’una yönlendirin.

## 3) Softphone kayıt bilgileri

İki farklı SIP istemcisi (veya aynı uygulamada iki hesap) ile kayıt olun:

- Hesap 1:
  - Kullanıcı: `SIP_EXTEN_1` (varsayılan `1000`)
  - Şifre: `SIP_PASSWORD_1`
- Hesap 2:
  - Kullanıcı: `SIP_EXTEN_2` (varsayılan `1001`)
  - Şifre: `SIP_PASSWORD_2`
- Sunucu/Domain: `EXTERNAL_IP`
- Port: `5080`
- Transport: UDP (gerekirse TCP)

## 4) Çağrı testi

1. İki hesap da `Registered` olduğunda, `1000` hesabından `1001` numarasını arayın.
2. Asterisk `Dial(PJSIP/${EXTEN})` ile çağrıyı hedef extension’a yönlendirir.

## 5) Doğrulama komutları

```bash
docker logs -f standalone-asterisk
docker exec -it standalone-asterisk asterisk -rx "pjsip show endpoints"
docker exec -it standalone-asterisk asterisk -rx "pjsip show contacts"
```

Helper container ile aynı host network üzerinde debug:

```bash
docker compose --env-file .env --profile helpers up -d sip-debug
docker exec -it standalone-sip-debug sh
```

## 6) Durdurma

```bash
docker compose --env-file .env down
```
