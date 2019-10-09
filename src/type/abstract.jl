#=
    AbstractGUI
      AbsractContext, AbstractContent
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
    AbstractContext

The abstraction for types that provide, characterize,
organize, or reflect context involved in realizing a GUI.
"""
abstract type AbstractContext  <: AbstractGUI end

"""
    AbstractContent

The abstraction for types that develop, bring, carry,
or hold content involved in realizing a GUI.
"""
abstract type AbstractContent <: AbstractGUI end

        
"""
    AbstractConstrain

The abstraction for types constraining aspects of elements
involved in realizing a GUI.
"""
abstract type AbstractConstrain <: AbstractGUI end

"""
    AbstractConstrainContext

The abstraction for types constraining aspects of elements
involved in realizing the Context of a GUI.
"""
abstract type AbstractConstrainContext <: AbstractConstrain end

"""
    AbstractConstrainContent

The abstraction for types constraining aspects of elements
involved in realizing the Content of a GUI.
"""
abstract type AbstractConstrainContent <: AbstractConstrain end


"""
    AbstractConstruct

The abstraction for types constructing aspects of elements
involved in realizing a GUI.
"""
abstract type AbstractConstruct <: AbstractGUI end

"""
    AbstractConstructContext

The abstraction for types constructing aspects of elements
involved in realizing the Context of a GUI.
"""
abstract type AbstractConstructContext <: AbstractConstruct end

"""
    AbstractConstructContent

The abstraction for types constructing aspects of elements
involved in realizing the Content of a GUI.
"""
abstract type AbstractConstructContent <: AbstractConstruct end


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
    AbstractContemperContext

The abstraction for types constructing aspects of elements
involved in realizing the Context of a GUI.
"""
abstract type AbstractContemperContext <: AbstractContemper end

"""
    AbstractContemperContent

The abstraction for types constructing aspects of elements
involved in realizing the Content of a GUI.
"""
abstract type AbstractContemperContent <: AbstractContemper end
