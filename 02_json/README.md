# README

Demonstrate how to deal with `json` data in Powershell

## Process

```ps1
# load json
$pokedex = get-content ./pokedex.json
# convert json
$pokedexjson = $pokedex | ConvertFrom-Json
# extract data
$pokedexjson.pokemon.name
```

## Resources

* Awesome JSON Datasets [here](https://project-awesome.org/jdorfman/awesome-json-datasets)  
