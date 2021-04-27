Class {
	#name : #WollokVMNative,
	#superclass : #Object,
	#instVars : [
		'expresion',
		'claseRetorno',
		'tipo'
	],
	#category : #'WollokVM-Interpreter'
}

{ #category : #accessing }
WollokVMNative >> claseRetorno [
	^ claseRetorno
]

{ #category : #'as yet unclassified' }
WollokVMNative >> claseRetorno: aString [ 
	claseRetorno := aString
]

{ #category : #'as yet unclassified' }
WollokVMNative >> ejecutarCon: argumentos sobre: receptor [ 
tipo = 'comun' 
	ifTrue:[ ^expresion value: receptor value: argumentos ].
tipo = 'binario'
	ifTrue:[ ^ expresion value: receptor value: argumentos first ].
tipo = 'unario'
	ifTrue:[ ^ expresion value: receptor].
^nil

	
			
]

{ #category : #'as yet unclassified' }
WollokVMNative >> expresion: aBlockClosure [ 
	expresion := aBlockClosure
]

{ #category : #'as yet unclassified' }
WollokVMNative >> tipo: aString [ 
	tipo := aString
]
