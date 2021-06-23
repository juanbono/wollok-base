Class {
	#name : #WollokVMLiteral,
	#superclass : #WollokVMObject,
	#instVars : [
		'literalValue'
	],
	#category : #'WollokVM-Interpreter'
}

{ #category : #'as yet unclassified' }
WollokVMLiteral >> booleanValue [
	^self literalValue = true.
]

{ #category : #accessing }
WollokVMLiteral >> literalValue [
	
	^ literalValue
]

{ #category : #accessing }
WollokVMLiteral >> literalValue: anObject [
	literalValue := anObject
]
