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
=#

"""
    AbstractGUI

The root for type abstractions involved in realizing a GUI.
"""
abstract type AbstractGUI end

"""
    AbstractContent

The abstraction for types that develop, bring, carry,
or hold content involved in realizing a GUI.
"""
abstract type AbstractContent <: AbstractGUI end

"""
    AbstractContext

The abstraction for types that provide, characterize,
organize, or reflect context involved in realizing a GUI.
"""
abstract type AbstractContext  <: AbstractGUI end

        
"""
    AbstractConstrain

The abstraction for types constraining aspects of elements
involved in realizing a GUI.
"""
abstract type AbstractConstrain <: AbstractGUI end

"""
    AbstractConstrainContent

The abstraction for types constraining aspects of elements
involved in realizing the Content of a GUI.
"""
abstract type AbstractConstrainContent <: AbstractConstrain end

"""
    AbstractConstrainContext

The abstraction for types constraining aspects of elements
involved in realizing the Context of a GUI.
"""
abstract type AbstractConstrainContext <: AbstractConstrain end


"""
    AbstractConstruct

The abstraction for types constructing aspects of elements
involved in realizing a GUI.
"""
abstract type AbstractConstruct <: AbstractGUI end

"""
    AbstractConstructContent

The abstraction for types constructing aspects of elements
involved in realizing the Content of a GUI.
"""
abstract type AbstractConstructContent <: AbstractConstruct end

"""
    AbstractConstructContext

The abstraction for types constructing aspects of elements
involved in realizing the Context of a GUI.
"""
abstract type AbstractConstructContext <: AbstractConstruct end



"""
    AbstractContemper

The abstraction for types contempering aspects of elements
involved in realizing a GUI.

_contemper_ "to gain pliable strength through tempering"
- [_with_][_tempering_]
- tempering through measured admixture of beneficials
"""
abstract type AbstractContemper <: AbstractGUI end

"""
    AbstractContemperContent

The abstraction for types constructing aspects of elements
involved in realizing the Content of a GUI.
"""
abstract type AbstractContemperContent <: AbstractContemper end

"""
    AbstractContemperContext

The abstraction for types constructing aspects of elements
involved in realizing the Context of a GUI.
"""
abstract type AbstractContemperContext <: AbstractContemper end

"""
    AbstractContexture

The abstraction for types contexturing aspects of elements
involved in realizing a GUI.

_contexture_ "a weaving together of consituent parts, the structural nature of their concomitance"
- [_with_][_texture_]
- tempering through measured admixture of beneficials
"""
abstract type AbstractContemper <: AbstractGUI end
