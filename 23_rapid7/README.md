# README

Demonstate using `rapid7` logs API

```ps1
. ./.env.ps1 
./rapid7.ps1 -logs
./rapid7.ps1 -logs | convertto-json -depth 100
```

```ps1
(./rapid7.ps1 -usage).per_day_usage.usage
(./rapid7.ps1 -usage) | convertto-json -depth 100
```

## Resources

* REST API Overview [here](https://docs.rapid7.com/insightops/rest-api-overview)
