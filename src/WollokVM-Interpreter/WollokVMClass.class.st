Class {
	#name : #WollokVMClass,
	#superclass : #Object,
	#instVars : [
		'name',
		'ast',
		'metodos',
		'atributos',
		'superClase',
		'nativos'
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

{ #category : #'as yet unclassified' }
WollokVMClass >> buscarNativo: selector [ 
	^nativos at: selector ifAbsent: nil
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
WollokVMClass >> configurar: definicionesNativas [ 
|posibleSuperClase |
ast elements first members do:
	[ :met | self agregarMetodo: met ].

ast elements first variables do:
	[ :atr | self agregarAtributo: atr ].


definicionesNativas do: [:definicion |
	nativos at: (definicion at:1) put: 
		(WollokVMNative new 
			expresion: (definicion at:2);
			claseRetorno: (definicion at:3);
			tipo: (definicion at:4);
			yourself)
		]. 

posibleSuperClase := ast elements first superclass.
superClase := (name = WollokASTInterpreter baseClassName) 
	ifTrue: [ nil ]
	ifFalse: [ posibleSuperClase 
		ifNil: [ WollokASTInterpreter baseClassName ] 
		ifNotNil: [posibleSuperClase asWollokQualifiedName ]
 	].
]

{ #category : #'as yet unclassified' }
WollokVMClass >> ejecutarNativo: selector con: argumentos sobre: receptor [ 
	^(nativos at:selector) value: receptor literalValue value: (argumentos collect: [ :a | a literalValue ])
]

{ #category : #accessing }
WollokVMClass >> initialize [ 

super initialize.
metodos := Dictionary new.
atributos := Dictionary new.
nativos := Dictionary new.
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
