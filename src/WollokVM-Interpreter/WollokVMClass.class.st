Class {
	#name : #WollokVMClass,
	#superclass : #Object,
	#instVars : [
		'name',
		'ast',
		'metodos',
		'atributos',
		'superClase'
	],
	#category : #'WollokVM-Interpreter'
}

{ #category : #accessing }
WollokVMClass >> agregarAtributo: atr [
 
| atributo |
 atributo := WollokVMAtribute new
				identificador: atr variableName;
				configurar: atr;
				yourself. 
				
atributos at: (atributo identificador) put: atributo

]

{ #category : #accessing }
WollokVMClass >> agregarMetodo: met [ 
 | metodo |
 metodo := WollokVMMethod new
				selector: met selector;
				configurar: met;
				clase: self;
				yourself. 
				
 metodos at: metodo selector put: metodo.
]

{ #category : #accessing }
WollokVMClass >> allVariables [

	self flag: #todo.
	^ #()
]

{ #category : #accessing }
WollokVMClass >> ast [
	^ ast
]

{ #category : #accessing }
WollokVMClass >> ast: anObject [
	ast := anObject
]

{ #category : #'as yet unclassified' }
WollokVMClass >> atributos [
	"self shouldBeImplemented"
	
	^ atributos
]

{ #category : #accessing }
WollokVMClass >> configurar [ 
|posibleSuperClase |
ast elements first members do:
	[ :met | self agregarMetodo: met ].

ast elements first variables do:
	[ :atr | self agregarAtributo: atr ].

posibleSuperClase := ast elements first superclass.
superClase := (name = WollokASTInterpreter baseClassName) 
	ifTrue: [ nil ]
	ifFalse: [ posibleSuperClase 
		ifNil: [ WollokASTInterpreter baseClassName ] 
		ifNotNil: [posibleSuperClase asWollokQualifiedName ]
 	].
]

{ #category : #accessing }
WollokVMClass >> initialize [ 

super initialize.
metodos := Dictionary new.
atributos := Dictionary new.
]

{ #category : #accessing }
WollokVMClass >> name [
	^ name
]

{ #category : #accessing }
WollokVMClass >> name: anObject [
	name := anObject
]

{ #category : #accessing }
WollokVMClass >> obtenerMetodo: selector [
	^ metodos at: selector

]

{ #category : #printing }
WollokVMClass >> printOn: aStream [

	super printOn: aStream.
	
	aStream
		space;
		nextPut: $(;
		print: name;
		nextPut: $)
		 
]

{ #category : #accessing }
WollokVMClass >> superClase [
	^ superClase
]

{ #category : #accessing }
WollokVMClass >> superClase: anObject [
	superClase := anObject
]

{ #category : #accessing }
WollokVMClass >> tieneMetodo: selector [

^ metodos keys includes: selector
]

{ #category : #accessing }
WollokVMClass >> tieneSuperClase [	
		
	^ superClase notNil 

]
