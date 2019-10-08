const html_ = m("html")

const head_ = m("head")
const title_ = m("title")
const meta_ = m("meta")

# sections https://html.spec.whatwg.org/#sections
const body_  = m("body")
const article_ = m("article")
const section_ = m("section")
const nav_ = m("nav")
const aside_ = m("aside")
const h1_ = m("h1")
const h2_ = m("h2")
const h3_ = m("h3")
const h4_ = m("h4")
const h5_ = m("h5")
const h6_ = m("h6")
const hgroup_ = m("hgroup")
const header_ = m("header")
const footer_ = m("footer")
const address_ = m("address")

# grouping https://html.spec.whatwg.org/#grouping-content
const p_ = m("p")
const hr_ = m("hr")
const pre_ = m("pre")
const blockquote_ = m("blockquote")
const ol_ = m("ol")
const ul_ = m("ul")
const menu_ = m("menu")
const li_ = m("li")
const dl_ = m("dl")
const dt_ = m("dt")
const dd_ = m("dd")
const figure_ = m("figure")
const figcaption_ = m("figcaption")
const main_ = m("main")
const div_ = m("div")

# table https://html.spec.whatwg.org/#tables
const table_ = m("table")
const caption_ = m("caption")
const colgroup_ = m("colgroup")
const col_ = m("col")
const tbody_ = m("tbody")
const thead_ = m("thead")
const tfoot_ = m("tfoot")
const tr_ = m("tr")
const td_ = m("td")
const th_ = m("th")

# text level https://html.spec.whatwg.org/#text-level-semantics
const a_ = m("a")
const em_ = m("em")
const strong_ = m("strong")
const small_ = m("small")
const s_ = m("s")
const cite_ = m("cite")
const q_ = m("q")
const dfn_ = m("dfn")
const abbr_ = m("abbr")
const ruby_ = m("ruby")
const rt_ = m("rt")
const rp_ = m("rp")
const data_ = m("data")
const time_ = m("time")
const code_ = m("code")
const var_ = m("var")
const samp_ = m("samp")
const kbd_ = m("kbd")
const sub_ = m("sub")
const sup_ = m("sup")
const i_ = m("i")
const b_ = m("b")
const u_ = m("u")
const mark_ = m("mark")
const bdi_ = m("bdi")
const bdo_ = m("bdo")
const span_ = m("span")
const br_ = m("br")
const wbr_ = m("wbr")

# input element types
const button_ = m("button")
const checkbox_ = m("checkbox")
const color_ = m("color")
const date_ = m("date")
const datetimelocal = m("datetimeLocal")
const email_ = m("email")
const file_ = m("file")
const hidden_ = m("hidden")
const image_ = m("image")
const month_ = m("month")
const number_ = m("number")
const password_ = m("password")
const radio_ = m("radio")
const range_ = m("range")
const reset_ = m("reset")
const search_ = m("search")
const submit_ = m("submit")
const tel_ = m("tel")
const text_ = m("text")
const time_ = m("time")
const url_ = m("url")
const week_ = m("week")

# link types
const a_alternate_ = a_(rel="alternate")
const a_author_ = a_(rel="author")
const a_bookmark_ = a_(rel="bookmark")
const a_canonical_ = a_(rel="canonical")
const a_dnsprefetch_ = a_(rel="dns-prefetch")
const a_external_ = a_(rel="external")
const a_help_ = a_(rel="help")
const a_icon_ = a_(rel="icon")
const a_license_ = a_(rel="license")
const a_modulepreupload_ = a_(rel="modulepreupload")
const a_nofollow_ = a_(rel="nofollow")
const a_noopener_ = a_(rel="noopener")
const a_noreferrer_ = a_(rel="noreferrer")
const a_opener_ = a_(rel="opener")
const a_pingback_ = a_(rel="pingback")
const a_preconnect_ = a_(rel="preconnect")
const a_prefetch_ = a_(rel="prefetch")
const a_preload_ = a_(rel="preload")
const a_prerender_ = a_(rel="prerender")
const a_search_ = a_(rel="search")
const a_stylesheet_ = a_(rel="stylesheet")
const a_tag_ = a_(rel="tag")
const a_next_ = a_(rel="next")
const a_prev_ = a_(rel="prev")

# area https://html.spec.whatwg.org/#the-area-element
const area_ = m("area")
const area_circle_ = area_(shape="circle")
const area_rectangle_ = area_(shape="rect")
const area_polygon_ = area_(shape_="poly")

### html attributes

# global attributes

const HTML_global_attributes = Set([
    :accesskey
    :autocapitalize
    :autofocus
    :contenteditable
    :dir
    :draggable
    :enterkeyhint
    :hidden
    :inputmode
    :is
    :itemid
    :itemprop
    :itemref
    :itemscope
    :itemtype
    :lang
    :nonce
    :spellcheck
    :style
    :tabindex
    :title
    :translate
  ])

const HTML_eventhandler_attributes = Set([
    :onabort
    :onauxclick
    :onblur
    :oncancel
    :oncanplay
    :oncanplaythrough
    :onchange
    :onclick
    :onclose
    :oncontextmenu
    :oncopy
    :oncuechange
    :oncut
    :ondblclick
    :ondrag
    :ondragend
    :ondragenter
    :ondragexit
    :ondragleave
    :ondragover
    :ondragstart
    :ondrop
    :ondurationchange
    :onemptied
    :onended
    :onerror
    :onfocus
    :onformdata
    :oninput
    :oninvalid
    :onkeydown
    :onkeypress
    :onkeyup
    :onload
    :onloadeddata
    :onloadedmetadata
    :onloadstart
    :onmousedown
    :onmouseenter
    :onmouseleave
    :onmousemove
    :onmouseout
    :onmouseover
    :onmouseup
    :onpaste
    :onpause
    :onplay
    :onplaying
    :onprogress
    :onratechange
    :onreset
    :onresize
    :onscroll
    :onsecuritypolicyviolation
    :onseeked
    :onseeking
    :onselect
    :onslotchange
    :onstalled
    :onsubmit
    :onsuspend
    :ontimeupdate
    :ontoggle
    :onvolumechange
    :onwaiting
    :onwheel
  ])
    
const HTML_image_attributes = Set([
    :alt
    :crossorigin
    :height
    :ismap
    :longdesc
    :sizes
    :src
    :srcset
    :usemap
    :width
  ])

#= kinds of HTML Input Attributes =#
    
const HTML_mostgeneral_input_attributes = Set([
    :autofocus
    :disabled
    :form
    :name
  ])

const HTML_broadlygeneral_input_attributes = Set([
    :autocomplete
    :placeholder
    :readonly
    :required
    :type
    :value
  ])

const HTML_moregeneral_input_attributs = union(HTML_mostgeneral_input_attributes, HTML_broadlygeneral_input_attributes)

const HTML_lessgeneral_input_attributes = Set([
    :list
    :multiple
    :pattern
    :size
    :step
  ])

const HTML_checkbox_input_attributes = Set([
    :checked
  ])

const HTML_file_input_attributes = Set([
    :accept
  ])

const HTML_form_input_attributes = Set([
    :formaction
    :formenctype
    :formmethod
    :formnovalidate
    :formtarget
  ])

 const HTML_image_input_attributes = Set([
    :alt
    :formaction
    :formenctype
    :formmethod
    :formtarget
    :height
    :src
    :width
  ])

const HTML_submit_input_attributes = Set([
    :formenctype
    :formmethod
    :formtarget
  ])

const HTML_input_attributes =
    union(HTML_moregeneral_input_attributes, HTML_less_general_input_attributes, 
          HTML_checkbox_input_attributes, HTML_file_input_attributes, HTML_form_input_attributes,
          HTML_image_input_attributs, HTML_submit_input_attributes) 

# select
    
const HTML_select_attributes =
    Set([:autofocus, :disabled, :form, :multiple, :name, :required, :size])

const HTML_option_attributes =
    Set([:disabled, :label, :selected, :value])

const HTML_optgroup_attributes =
    Set([:disabled, :label])

# list

const HTML_ol_attributes =
    Set([:reversed, :start, :type])

const HTML_ul_attributes = Set([])

# style
const HTML_style_attributes =
    Set([:media, :type])


# elements with global_attributes only

const HTML_nav_attributes = Set([])
# table
const HTML_table_attributes = Set([])
const HTML_tbody_attributes = Set([])
const HTML_td_attributes = Set([])
const HTML_tfoot_attributes = Set([])
const HTML_th_attributes = Set([])
const HTML_thead_attributes = Set([])
const HTML_tr_attributes = Set([])

