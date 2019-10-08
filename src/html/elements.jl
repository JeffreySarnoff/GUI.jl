# all also support the HTML_global_attributes
const ElementAttributes = Dict{Symbol, Set}(
    :button => Set([:autofocus, :disabled, :name, :type, :value, 
                    :form, :formaction, :formenctype, :formmethod, :formnovalidate, :formtarget]),
    :button_unattached => Set([:autofocus, :disabled, :name, :type, :value]),
    :img => Set([:alt, :crossorigin, :height, :ismap, :longdesc, :sizes, :src, :srcset, :usemap, :width]),
    :label => Set([:for, :form]),
  )

# Events

const WindowEvents = Set([:onafterprint, :onbeforeprint, : onbeforeunload, :onerror, :onhashchange, :onload, :onmessage,
                          :onoffline, :ononline, :onpagehide, :onpageshow, :onpopsate, :onresize, :onstorage, :onunload])
const FormEvents = Set([:onblur, :onchange, :oncontextmenu, :onfocus, :oninput, :oninvalid, :onreset, :onsearch, :onselect, :onsubmit])
const KeyboardEvents = Set([:onkeydown, :onkeypress, :onkeyup])
const MouseEvents = Set([:onclick, :ondblclick, :onmousedown, :onmousemove, :onmouseout, :onmouseover, :onmouseup, :onwheeel])
const DragEvents = Set([:ondrag, :ondragend, :ondregenter, :ondragleave, :ondragover, :ondragstart, :ondrop, :onscroll])
const ClipboardEvents = Set([:oncopy, :oncut, :onpaste])
const MediaEvents = Set([:onabort, :oncanplay, :oncanplaythrough, oncuechange, :ondurationchange, :oneemptied, :onended, :onerror,
                         :onloadeddata, :onloadedmetadata, :onloadstart, :onpause, :onplay, :onplaying, :onprogress,
                         :onratechange, :onseeked, :onseeking, :onstalled, :onsuspend, :ontimeupdate, :onvolumechange, :onwaiting])
const DetailsEvents = Set([:ontoggle,])
