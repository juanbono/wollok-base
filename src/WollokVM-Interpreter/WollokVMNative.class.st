Class {
	#name : #WollokVMNative,
	#superclass : #Object,
	#instVars : [
		'expresion',
		'claseRetorno',
		'tipo',
		'claseArgumentos'
	],
	#category : #'WollokVM-Interpreter'
}

{ #category : #'as yet unclassified' }
WollokVMNative >> argumentoWObject [
	^	claseArgumentos = 'obj'
]

{ #category : #accessing }
WollokVMNative >> claseArgumentos [
	^ claseArgumentos
]

{ #category : #accessing }
WollokVMNative >> claseArgumentos: anObject [
	claseArgumentos := anObject
]

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
WollokVMNative >> retornoWObject [
	^	claseRetorno = 'obj'
]

{ #category : #'as yet unclassified' }
WollokVMNative >> tipo: aString [ 
	tipo := aString
]
