#=

<!DOCTYPE html?
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>""</title>
</head>
<body>
</body>
</html>

=#
#=
<!DOCTYPE HTML>
<html lang="en">
 <head>
  <title>Online or offline?</title>
<script>
   function isonline(online) {
     document.getElementById('online').textContent =
       online;
   }
  </script>
 </head>
 <body ononline="isonline(true)"
       onoffline="isonline(false)"
       onload="isonline(navigator.onLine)">
  <p>are you online? <span id="online">(Unknown)</span></p>
 </body>
</html>
=#

using Base: String
using URIParser

struct HtmlHead
    charset::String
    title::String
    base::String
    
    function HtmleHead(;charset::String="UTF-8", title::String="", base::String="")
        return new(charset, title, base)
    end
end

struct HtmlBody
end

struct HtmlPage
    doctype::String
    lang::String
    head::HtmlHead
    body::HtmlBody
    
    function HtmlPage(; doctype::String="html", lang::String="en", head::HtmlHead=HtmlHead(), body::HtmlBody=HtmlBody())
       return new(doctype, lang, head, body)
    end
end

function string(html::HtmlPage)
    result = string("<DOCTYPE ", html.doctype,">\n")
    result = string(result, "<html lang=\"", html.lang, "\">\n")
    result = string(result, html.head)
    result = string(result, html.body)
    result = string(result, "<\\html>\n")
    return result
end

function string(head::HtmlHead)
    result = "<head>\n"
    result = string(result, "  <meta charset=\"", html.head.charset, "\">\n")
    result = string(result, "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n")
    if !isempty(html.head.base)
        result = string(result, "  <title>", html.head.title,"</title>\n")
    end
    if !isempty(html.head.title)
        result = string(result, "  <base href=\"", html.head.base,">\n")
    end
    result = string(result, "<\\head>\n")
    return result
end
 
function string(body::HtmlBody)
end
