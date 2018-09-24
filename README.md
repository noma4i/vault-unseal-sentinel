# Vault Unseal Sentinel

**What it can do:** Unseal your VAULT every given tick

## How to

`docker-compose up`

## Configuration

- `VAULT_ADDR` - pointing to your vault instance
- `UNSEAL_KEYS` - list of unseal tokens whitespace separated
- `RECHECK_TIME` - deafults to 10 seconds but you are free to override it

Example:

```
  VAULT_ADDR=http://vault.donesafe.com:8200
  UNSEAL_KEYS=JulhuM4tVbNoyIOijBtvPm0CBZcU8ae3gOrIecZIPpTK EkNOd6KdbBJqv73Rf9jK/lTzfzPHrAPbvHX0MpU3yOVi TgH2wqMPJb1ifrZHL+KQA01O2CzHRpl+TYVHR5A5HmlX

```

## Showtime

![Sealed](media/sealed.png?raw=true)

```
vault.unseal-sentinel | Starting Sentenial
vault.unseal-sentinel | Looking after VAULT at: http://vault.example.com:8200
vault.unseal-sentinel | Will unseal every 10 seconds
vault.unseal-sentinel | Vault has been unsealed on 09/24/18 06:52:56
```
![Sealed](media/unsealed.png?raw=true)


## Author

[Alexander Tsirel @noma4i](https://github.com/noma4i)

## Contribution Guide

Open Issue or send PR ;)
