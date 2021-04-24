Class {
	#name : #WollokVMMethod,
	#superclass : #Object,
	#instVars : [
		'ast',
		'selector',
		'argumentos',
		'clase'
	],
	#category : #'WollokVM-Interpreter'
}

{ #category : #'as yet unclassified' }
WollokVMMethod >> argumentos [
	^ argumentos
]

{ #category : #accessing }
WollokVMMethod >> ast [
	^ ast
]

{ #category : #accessing }
WollokVMMethod >> clase [
	^ clase
]

{ #category : #accessing }
WollokVMMethod >> clase: anObject [
	clase := anObject
]

{ #category : #'as yet unclassified' }
WollokVMMethod >> configurar: node [ 
	ast := node. 
	ast parameters do: 
		[ :par | argumentos at: par identificador put: par  ]
	
]

{ #category : #'as yet unclassified' }
WollokVMMethod >> initialize [
	argumentos := Dictionary new
	
]

{ #category : #accessing }
WollokVMMethod >> selector [
	^ selector
]

{ #category : #accessing }
WollokVMMethod >> selector: anObject [
	selector := anObject
]

{ #category : #'as yet unclassified' }
WollokVMMethod >> superClase [
	^clase superClase.
]
