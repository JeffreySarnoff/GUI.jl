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
struct HtmlHead
    charset::String
    title::String
    
    function HtmleHead(;charset::String="UTF-8", title::String="")
        return new(charset=charset, title=title)
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
       return new(doctype=doctype, lang=lang, head=head, body=body)
    end
end

function Base.string(html::HtmlPage)
    result = string("<DOCTYPE ", html.doctype,">\n")
    result = string(result, "<html lang=\"", html.lang, "\">\n")
    result = string(result, html.head)
    result = string(result, html.body)
    result = string(result, "<\html>\n")
    return result
end

function Nase.string(head::HtmlHead)
    result = "<head>\n"
    result = string(result, "  <meta charset=\"", html.head.charset, "\">\n")
    result = string(result, "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n")
    if !isempty(html.head.title)
        result = string(result, "  <title>", html.head.title,"</title>\n")
    end
    result = string(result, "</head>\n")
    return result
end
 
function Base.string(body::HtmlBody)
end
