Class {
	#name : #WollokVMBClosure,
	#superclass : #WollokVMLiteral,
	#instVars : [
		'expresiones',
		'ambienteExterior',
		'parametros',
		'interprete'
	],
	#category : #'WollokVM-Interpreter'
}

{ #category : #'as yet unclassified' }
WollokVMBClosure >> ambienteExterior: aWollokVMAmbiente [ 
	ambienteExterior := aWollokVMAmbiente
]

{ #category : #'as yet unclassified' }
WollokVMBClosure >> expresiones: aWollokBlockExpressionNode [ 
	expresiones := aWollokBlockExpressionNode
]

{ #category : #'as yet unclassified' }
WollokVMBClosure >> interprete: aWollokASTInterpreter [ 
	interprete := aWollokASTInterpreter
]

{ #category : #'as yet unclassified' }
WollokVMBClosure >> literalValue [
 |nuevoAmbiente resultado |
"[(expresiones collect: [ :exp | exp acceptVisitor: interprete ]"
	"ambienteAnterior:= ambiente.
	interprete ambienteActual: ambiente ambienteMayor: ambienteExterior."



	
	parametros isEmpty
		ifTrue: [ ^[resultado := expresiones acceptVisitor: interprete.
	resultado]].

	(parametros size = 1) 
		ifTrue: [ 
			^[ :a | nuevoAmbiente := WollokVMAmbiente new 
							ambienteMayor: ambiente;
							ambienteAnterior: interprete ambienteActual;
							yourself.
					interprete ambienteActual: nuevoAmbiente.

					nuevoAmbiente agregarReferencia: parametros first identificador inicializadaEn: a.

					resultado := expresiones acceptVisitor: interprete.
					
					interprete ambienteActual: (interprete ambienteActual ambienteAnterior).
					resultado
					 ]
				].
	(parametros size = 2) 
		ifTrue: [ 
			^[ :a :b | nuevoAmbiente := WollokVMAmbiente new 
							ambienteMayor: ambiente;
							ambienteAnterior: interprete ambienteActual;
							yourself.
					interprete ambienteActual: nuevoAmbiente.

					nuevoAmbiente agregarReferencia: parametros first identificador inicializadaEn: a.
					nuevoAmbiente agregarReferencia: parametros last identificador inicializadaEn: b.

					resultado := expresiones acceptVisitor: interprete.
					
					interprete ambienteActual: (interprete ambienteActual ambienteAnterior).
					resultado
					 ]
				].
]

{ #category : #'as yet unclassified' }
WollokVMBClosure >> parametros: aCollection [ 
	parametros := aCollection
]
