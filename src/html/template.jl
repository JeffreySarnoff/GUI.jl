const HTML_minimal_template = mt"""
<!DOCTYPE html>
<html lang=\"{{{:lang}}}\">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content=\"{{{:viewport_content}}}\">

  <title>{{{:title}}}</title>
</head>
<body>
</body>
</html>
"""

HTML_minimal_dict = Dict(
  :lang => "en",
  :viewport_content => "width=device-width, initial-scale=1",
  :title => "Untitled",
)
# :bulma => "<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.5/css/bulma.min.css">"
# :fontawesome => "<script defer src="https://use.fontawesome.com/releases/v5.3.1/js/all.js"></script>"


HTML_dict = DefaultDict(0, HTML_minimal_dict)

#=
res = Mustache.render(HTML_minimal_template, HTML_dict)
print(res)

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Untitled</title>
</head>
<body>
</body>
</html>

using EzXML
root = root(parsehtml(res))
head = firstelement(root)
@assert head.name == "head"
body = lastelement(root)
@assert body.name == "body"


julia> @tags div h1
WARNING: redefining constant div
WARNING: redefining constant h1

julia> const entry = div.entry
WARNING: redefining constant entry
<div class="entry"></div>

julia> entry(h1("An Important Announcement"))
<div class="entry"><h1>An Important Announcement</h1></div>

julia> s = string(entry(h1("An Important Announcement")))
"<div class=\"entry\"><h1>An Important Announcement</h1></div>"

julia> p=parsehtml(s)
EzXML.Document(EzXML.Node(<HTML_DOCUMENT_NODE@0x000000000136f800>))

julia> b=lastelement(root(p))
EzXML.Node(<ELEMENT_NODE[body]@0x000000003c9b45f0>)

julia> prettyprint(b)
<body>
  <div class="entry">
    <h1>An Important Announcement</h1>
  </div>
</body>
julia> string(b)
"<body><div class=\"entry\"><h1>An Important Announcement</h1></div></body>"


julia> for x in eachelement(root(parsehtml(res)))
          for y in eachelement(x)
            println(y.name)
           end
           end
meta
meta
title

julia> for x in eachelement(root(parsehtml(res)))
          for y in eachelement(x)
            for a in (attributes(y))
               println(a.name,": ",a.content)
           end
           end
           end

charset: utf-8
name: viewport
content: width=device-width, initial-scale=1

=#
