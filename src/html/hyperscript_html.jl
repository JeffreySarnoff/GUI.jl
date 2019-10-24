export  hyperhtml,
    html_, head_, title_, meta_,
    # sections https://html.spec.whatwg.org/#sections
    body_, article_, section_, nav_, aside_,
    h1_, h2_, h3_, h4_, h5_, h6_,
    hgroup_, header_, footer_, address_,
    # grouping https://html.spec.whatwg.org/#grouping-content
    p_, hr_, pre_, blockquote_, ol_, ul_,
    menu_, li_, dl_, dt_, dd_, figure_,
    figcaption_, main_, div_,
    # table https://html.spec.whatwg.org/#tables
    table_, caption_, colgroup_, col_, tbody_,
    thead_, tfoot_, tr_, td_,  th_,
    # text level https://html.spec.whatwg.org/#text-level-semantics
    a_, em_, strong_, small_, s_, cite_,
    q_, dfn_, abbr_, ruby_, rt_, rp_,
    data_, code_, var_, samp_, kbd_,
    sub_, sup_, i_, b_, u_, mark_,
    bdi_, bdo_, span_, br_, wbr_,
    # input element types
    button_, checkbox_, color_, date_,
    datetimeLocal_, email_, file_, hidden_,
    image_, month_, number_, password_,
    radio_, range_, reset_, search_, submit_,
    tel_, text_, time_, url_, week_,
    # other
    area_

hyperhtml = Dict{Symbol, Node{HTMLSVG}}[]

for (T,F) in (("html", :html_), ("head", :head_), ("title", :title_), ("meta", :meta_),
     # sections https://html.spec.whatwg.org/#sections
    ("body", :body_),  ("article", :article_), ("section", :section_), ("nav", :nav_), ("aside", :aside_),
    ("h1", :h1_), ("h2", :h2_), ("h3", :h3_), ("h4", :h4_), ("h5", :h5_), ("h6", :h6_),
    ("hgroup", :hgroup_), ("header", :header_), ("footer", :footer_), ("address", :address_),
    # grouping https://html.spec.whatwg.org/#grouping-content
    ("p", :p_), ("hr", :hr_), ("pre", :pre_), ("blockquote", :blockquote_), ("ol", :ol_), ("ul", :ul_),
    ("menu", :menu_), ("li", :li_), ("dl", :dl_), ("dt", :dt_), ("dd", :dd_), ("figure", :figure_),
    ("figcaption", :figcaption_), ("main", :main_), ("div", :div_),
    # table https://html.spec.whatwg.org/#tables
    ("table", :table_), ("caption", :caption_), ("colgroup", :colgroup_), ("col", :col_), ("tbody", :tbody_),
    ("thead", :thead_), ("tfoot", :tfoot_), ("tr", :tr_), ("td", :td_),  ("th", :th_),
    # text level https://html.spec.whatwg.org/#text-level-semantics
    ("a", :a_), ("em", :em_), ("strong", :strong_), ("small", :small_), ("s", :s_), ("cite", :cite_),
    ("q", :q_), ("dfn", :dfn_), ("abbr", :abbr_), ("ruby", :ruby_), ("rt", :rt_), ("rp", :rp_),
    ("data", :data_), ("code", :code_), ("var", :var_), ("samp", :samp_), ("kbd", :kbd_),
    ("sub", :sub_), ("sup", :sup_), ("i", :i_), ("b", :b_), ("u", :u_), ("mark", :mark_),
    ("bdi", :bdi_), ("bdo", :bdo_), ("span", :span_), ("br", :br_), ("wbr", :wbr_),
    # input element types
    ("button", :button_), ("checkbox", :checkbox_), ("color", :color_), ("date", :date_),
    ("datetimeLocal", :datetimeLocal_), ("email", :email_), ("file", :file_), ("hidden", :hidden_),
    ("image", :image_), ("month", :month_), ("number", :number_), ("password", :password_),
    ("radio", :radio_), ("range", :range_), ("reset", :reset_), ("search", :search_), ("submit", :submit_),
    ("tel", :tel_), ("text", :text_), ("time", :time_), ("url", :url_), ("week", :week_),
    # other
    ("area", :area_),
    )      
  @eval begin
     $F() = m($T)
     hyperhtml[Symbol($T)] = $F
     $F(class::String) = m($T, class=class)
     function $F(class::String, xs::Vararg{Pair,N}) where {N}
         dict = Dict(xs)
         dict[:class] = class      
         return Hyperscript.Node(Hyperscript.DEFAULT_HTMLSVG_CONTEXT, $T, [], dict)
     end          
     function $F(xs::Vararg{Pair,N}) where {N}
         dict = Dict(xs)
         return Hyperscript.Node(Hyperscript.DEFAULT_HTMLSVG_CONTEXT, $T, [], dict)
     end          
  end
end


# link types
const a_alternate_ = a_(:rel=>"alternate")
const a_author_ = a_(:rel=>"author")
const a_bookmark_ = a_(:rel=>"bookmark")
const a_canonical_ = a_(:rel=>"canonical")
const a_dnsprefetch_ = a_(:rel=>"dns-prefetch")
const a_external_ = a_(:rel=>"external")
const a_help_ = a_(:rel=>"help")
const a_icon_ = a_(:rel=>"icon")
const a_license_ = a_(:rel=>"license")
const a_modulepreupload_ = a_(:rel=>"modulepreupload")
const a_nofollow_ = a_(:rel=>"nofollow")
const a_noopener_ = a_(:rel=>"noopener")
const a_noreferrer_ = a_(:rel=>"noreferrer")
const a_opener_ = a_(:rel=>"opener")
const a_pingback_ = a_(:rel=>"pingback")
const a_preconnect_ = a_(:rel=>"preconnect")
const a_prefetch_ = a_(:rel=>"prefetch")
const a_preload_ = a_(:rel=>"preload")
const a_prerender_ = a_(:rel=>"prerender")
const a_search_ = a_(:rel=>"search")
const a_stylesheet_ = a_(:rel=>"stylesheet")
const a_tag_ = a_(:rel=>"tag")
const a_next_ = a_(:rel=>"next")
const a_prev_ = a_(:rel=>"prev")

# area https://html.spec.whatwg.org/#the-area-element
const area_circle_ = area_(:shape=>"circle")
const area_rectangle_ = area_(:shape=>"rect")
const area_polygon_ = area_(:shape=>"poly")

### html elements

# html elements
const HTML_global_elements = Set([:html, :head, :body])
const HTML_head_elements = Set([:title, :meta])
const HTML_section_elements = Set([
    :body, :article, :section, :nav, :aside,
    :h1, :h2, :h3, :h4, :h5, :h6,
    :hgroup, :header, :footer, :address])
const HTML_grouping_elements = Set([
    :p, :hr, :pre, :blockquote, :ol, :ul,
    :menu, :li, :dl, :dt, :dd, :figure,
    :figcaption, :main, :div])
const HTML_table_elements = Set([
    :table, :caption, :colgroup, :col, :tbody,
    :thead, :tfoot, :tr, :td, :th])
const HTML_text_elements = Set([
    :a, :em, :strong, :small, :s, :cite,
    :q, :dfn, :abbr, :ruby, :rt, :rp,
    :data, :code, :var, :samp, :kbd,
    :sub, :sup, :i, :b, :u, :mark,
    :bdi, :bdo, :span, :br, :wbr])
const HTML_input_elements = Set([
    :button, :checkbox, :color, :date,
    :datetimeLocal, :email, :file, :hidden,
    :image, :month, :number, :password,
    :radio, :range, :reset, :search, :submit,
    :tel, :text, :time, :url, :week])
const HTML_other_elements = Set([:area])

const HTML_elements = union(HTML_global_elements, HTML_head_elements, HTML_section_elements, HTML_grouping_elements,
    HTML_table_elements, HTML_text_elements, HTML_input_elements, HTML_other_elements)


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

const HTML_moregeneral_input_attributes = union(HTML_mostgeneral_input_attributes, HTML_broadlygeneral_input_attributes)

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
    union(HTML_moregeneral_input_attributes, HTML_lessgeneral_input_attributes, 
          HTML_checkbox_input_attributes, HTML_file_input_attributes, HTML_form_input_attributes,
          HTML_image_input_attributes, HTML_submit_input_attributes) 

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

