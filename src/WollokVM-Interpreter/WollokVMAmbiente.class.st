Class {
	#name : #WollokVMAmbiente,
	#superclass : #Object,
	#instVars : [
		'referencias',
		'ambienteMayor',
		'ambienteAnterior'
	],
	#category : #'WollokVM-Interpreter'
}

{ #category : #initialization }
WollokVMAmbiente >> agregarReferencia: identificador inicializadaEn: aWollokVMObject [
referencias at: identificador put: aWollokVMObject  
]

{ #category : #accessing }
WollokVMAmbiente >> ambienteAnterior [
	^ ambienteAnterior
]

{ #category : #accessing }
WollokVMAmbiente >> ambienteAnterior: anObject [
	ambienteAnterior := anObject
]

{ #category : #accessing }
WollokVMAmbiente >> ambienteMayor [
	^ ambienteMayor
]

{ #category : #accessing }
WollokVMAmbiente >> ambienteMayor: anObject [
	ambienteMayor := anObject
]

{ #category : #initialization }
WollokVMAmbiente >> asignarA: identificador 	elValor: aWollokVMObject [
	
(referencias keys includes: identificador)
	ifTrue: [ referencias at: identificador put: aWollokVMObject ]
	ifFalse: [ ambienteMayor 
		ifNil: [ self error ]
		ifNotNil: [ ambienteMayor asignarA: identificador elValor: aWollokVMObject ]
	]
]

{ #category : #initialization }
WollokVMAmbiente >> initialize [ 

super initialize.
referencias :=  Dictionary new.
]

{ #category : #'as yet unclassified' }
WollokVMAmbiente >> referencias [
	^ referencias
]

{ #category : #initialization }
WollokVMAmbiente >> resolverReferencia: identificador [ 

^(referencias keys includes: identificador)
	ifTrue: [ referencias at: identificador]
	ifFalse: [ ambienteMayor 
		ifNil: [ self error ]
		ifNotNil: [ ambienteMayor resolverReferencia: identificador ]
	]
]
