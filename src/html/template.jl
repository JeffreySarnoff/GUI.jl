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
  :title => "Untitled"
)

#=
res = Mustache.render(HTML_minimal_template, HTML_minimal_dict)
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
=#
