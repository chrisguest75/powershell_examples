# README

Demonstate using `trint` live API  

```ps1
. ./.env.ps1 
```

## Quick start

Creating a realtime using pull.  

```ps1
# start a pull
./trint-realtime.ps1 -pull   
./trint-realtime.ps1 -status -trintid M8z041GabcdefxxxMg 
./trint-realtime.ps1 -stop -trintid M8z041GabcdefxxxMg 
./trint-realtime.ps1 -status -trintid M8z041GabcdefxxxMg
./trint-realtime.ps1 -export -trintid M8z041GabcdefxxxMg
```

## Start a pull

```ps1
$trintid=(./trint-realtime.ps1 -pull -title "anothertest" )._id
./trint-realtime.ps1 -status -trintid $trintid
./trint-realtime.ps1 -export -trintid $trintid
# export as text
curl (./trint-realtime.ps1 -export -trintid $trintid -format text).url
./trint-realtime.ps1 -stop -trintid $trintid
```

## Start a push

```ps1
./trint-realtime.ps1 -push
$push = (./trint-realtime.ps1 -push)   
# output ffmpeg command
write-host ("ffmpeg -re -i https://nhkworld.webcdn.stream.ne.jp/www11/nhkworld-tv/global/2003458/live.m3u8 -f flv " + $push.streamUrl + "/" + $push.streamKey)

# start it in another window
ffmpeg -re -i https://nhkworld.webcdn.stream.ne.jp/www11/nhkworld-tv/global/2003458/live.m3u8 -f flv rtmps://stream.trint.com/live/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx

# check status
./trint-realtime.ps1 -status -trintid $push.trintId
./trint-realtime.ps1 -export -trintid $push.trintId
curl (./trint-realtime.ps1 -export -trintid $push.trintId -format text).url
./trint-realtime.ps1 -stop -trintid $push.trintId
```

## Resources

* The Trint API Developer Hub [here](https://dev.trint.com/)  
