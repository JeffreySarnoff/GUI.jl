# Using Google Fonts

## the link for one font
```
julia> googlefont("IBM Plex Mono")
"<link href="https://fonts.googleapis.com/css?family=IBM+Plex+Mono:400&display=fallback" rel="stylesheet">"

julia> googlefont("IBM Plex Mono", sizes=[400, 600])
"<link href="https://fonts.googleapis.com/css?family=IBM+Plex+Mono:400,600&display=fallback" rel="stylesheet">"

julia> googlefont("IBM Plex Mono", styles=["", "i"])
"<link href="https://fonts.googleapis.com/css?family=IBM+Plex+Mono:400,400i&display=fallback" rel="stylesheet">"

julia> googlefont("IBM Plex Mono", sizes=[400, 600], styles=["", "i"])
"<link href="https://fonts.googleapis.com/css?family=IBM+Plex+Mono:400,600,400i,600i&display=fallback" rel="stylesheet">"
```

## the link for multiple fonts
```
julia> googlefont(["IBM Plex Mono", "Roboto"])
"<link href="https://fonts.googleapis.com/css?family=IBM+Plex+Mono:400|Roboto:400&display=fallback" rel="stylesheet">"

julia> googlefont(["IBM Plex Mono", "Roboto"], sizes=[[400], [400, 600]])
"<link href="https://fonts.googleapis.com/css?family=IBM+Plex+Mono:400|Roboto:400,600&display=fallback" rel="stylesheet">"

julia> googlefont(["IBM Plex Mono", "Roboto"], sizes=[[400], [400, 600]], styles=[["", "i"],[""]])
"<link href="https://fonts.googleapis.com/css?family=IBM+Plex+Mono:400,400i|Roboto:400,600&display=fallback" rel="stylesheet">"
```
