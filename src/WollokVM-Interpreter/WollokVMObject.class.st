Class {
	#name : #WollokVMObject,
	#superclass : #Object,
	#instVars : [
		'wollokClass',
		'ambiente'
	],
	#category : #'WollokVM-Interpreter'
}

{ #category : #accessing }
WollokVMObject >> ambiente [
	^ ambiente
]

{ #category : #accessing }
WollokVMObject >> ambiente: anObject [
	ambiente := anObject
]

{ #category : #UI }
WollokVMObject >> gtInspectorVariablesIn: composite [
	<gtInspectorPresentationOrder: 1> 

	^ composite fastTable
		title: 'Wollok Inspector';
		display: [ self valueCollection ];
		column: 'Name' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Value' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ];
		send: [ :selection | 
			selection
				ifNil: [ nil ]
				ifNotNil: [ selection value ] ]
]

{ #category : #'as yet unclassified' }
WollokVMObject >> inicializarAtributo: identificador  conValor: aWollokVMObject [ 
	ambiente agregarReferencia: identificador inicializadaEn: aWollokVMObject 
]

{ #category : #'as yet unclassified' }
WollokVMObject >> initialize [
super initialize.

]

{ #category : #accessing }
WollokVMObject >> instanceVariablesValues [

	^ #()
]

{ #category : #printing }
WollokVMObject >> printOn: aStream [

	super printOn: aStream.
	
	aStream
		space;
		nextPut: $(;
		print: wollokClass;
		nextPut: $)

		 
]

{ #category : #'as yet unclassified' }
WollokVMObject >> recibirMensaje: aString con: aCollection [ 
	self shouldBeImplemented.
]

{ #category : #accessing }
WollokVMObject >> valueCollection [

	^ { 'self' -> self }, 
			(self wollokClass allVariables
				with: self instanceVariablesValues
				collect: [ :n :v | n key variable name value -> v ])
]

{ #category : #accessing }
WollokVMObject >> wollokClass [
	^ wollokClass
]

{ #category : #accessing }
WollokVMObject >> wollokClass: anObject [
	wollokClass := anObject
]

{ #category : #accessing }
WollokVMObject >> wollokClassName [
	
	^ wollokClass name
]
