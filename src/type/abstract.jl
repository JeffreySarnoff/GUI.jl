#=
    AbstractGUI
    AbstractConstrain, AbstractConstruct, AbstractContemper
    AbsractContent, AbstractContext
=#

"""
    AbstractGUI

The root for type abstractions involved in realizing a GUI.
"""
abstract type AbstractGUI end

"""
    AbstractConstrain

The abstraction for types constraining aspects of elements involved in realizing a GUI.
"""
abstract type AbstractConstrain <: AbstractGUI end

"""
    AbstractConstruct

The abstraction for types constructing aspects of elements involved in realizing a GUI.
"""
abstract type AbstractConstruct <: AbstractGUI end

"""
    AbstractContemper

- __contemper__: [_with_][_tempering_], tempering through measured admixture

The abstraction for types contempering aspects of elements involved in realizing a GUI.
"""
abstract type AbstractContemper <: AbstractGUI end

"""
    AbstractContent

The abstraction for types that develop, bring, carry, or hold content involved in realizing a GUI.
"""
abstract type AbstractContent  end

"""
    AbstractContext

The abstraction for types that provide, characterize, organize, or reflect context involved in realizing a GUI.
"""
abstract type AbstractContext  end
