#=
    AbstractGUI
      AbsractContent, AbstractContext
         AbstractConstrain, AbstractConstruct, AbstractContemper

     AbstractGUI
       AbstractContent
          AbstractConstrainContent
          AbstractConstructContent
          AbstractContemperContent
       AbstractContext
          AbstractConstrainContext
          AbstractConstructContext
          AbstractContemperContext


                                                   AbstractGUI
                       AbstractContent                                     AbstractContext
                   AbstractConstrainContent                             AbstractConstrainContext
                   AbstractConstructContent                             AbstractConstructContext
                   AbstractContemperContent                             AbstractContemperContext
=#

#=
    An Algebra of Content and Context

    Jeffrey Sarnoff 2019-Oct-09

    Context pervades, informs, reflects  Content
    Content suffuses, regards, mapsfrom  Context


=#

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
