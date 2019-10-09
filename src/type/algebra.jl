#=
    AbstractGUI
      AbstractContext, AbsractContent
         AbstractConstrain, AbstractConstruct, AbstractContemper


                                                   AbstractGUI
                            AbstractContext                                     AbstractContent
                   AbstractConstrainContext                             AbstractConstrainContent
                   AbstractConstructContext                             AbstractConstructContent
                   AbstractContemperContext                             AbstractContemperContent

=#

#=
    An Algebra of Content and Context

    Jeffrey Sarnoff 2019-Oct-09

    Context pervades, informs, reflects  Content
    Content suffuses, regards, mapsfrom  Context


=#

@trait MeroTopoi{X<:AbstractContext, N<:AbstractContent} begin
    value :: [T] => V  # typeof(value(T)) ==  V
end

@trait Dot{F, V} where {F = vect_infer_helper(V)} begin
    dot :: [V, V] => F
    gram_schmidt :: [V, Set{V}] => V
end

#=
   Media Types (MIME categories)

   application
   audio
   example
   font
   image
   message
   model
   multipart
   text
   video
=#

@enum MediaType begin
   nothing = 0
   application
   audio
   example
   font
   image
   message
   model
   multipart
   text
   video
end

struct Content <: AbstractContent
    uri::MaybeURI
    mime::MaybeMIME
    media::MediaType
    graph::Boolean
    fromapp::String
end

const MaybeContent = Union{Nothing, Content}
iscontent(x::MaybeContent) = !isnothing(x)
iscontent(x::Content) = true
iscontent(x) = false

struct Context <: AbastractContext
    above::MaybeContent
    below::MaybeContent
    before::MaybeContent
    after::MaybeContent
    backgroundcolor::Color
    foregroundcolor::Color
    fontspec::FontSpec
end

const MaybeContext = Union{Nothing, Context}
isconteext(x::MaybeContext) = !isnothing(x)
isccontext(x::Context) = true
iscontext(x) = false
