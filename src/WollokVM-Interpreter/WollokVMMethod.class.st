Class {
	#name : #WollokVMMethod,
	#superclass : #Object,
	#instVars : [
		'ast',
		'selector',
		'argumentos',
		'clase',
		'nativo'
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

{ #category : #'as yet unclassified' }
WollokVMMethod >> buscarNativo [
	^clase buscarNativo: selector 
		
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
	nativo := ast isNative.
	ast parameters do: 
		[ :par | argumentos at: par identificador put: par  ]
	
]

{ #category : #'as yet unclassified' }
WollokVMMethod >> ejecutarNativoCon: aCollection sobre: aWollokVMLiteral [ 
	^clase ejecutarNativo: selector con:aCollection sobre:aWollokVMLiteral
		
]

{ #category : #'as yet unclassified' }
WollokVMMethod >> initialize [
	argumentos := Dictionary new
	
]

{ #category : #'as yet unclassified' }
WollokVMMethod >> nativo [
	^ nativo
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
