Class {
	#name : #WollokVMAtribute,
	#superclass : #Object,
	#instVars : [
		'identificador',
		'ast'
	],
	#category : #'WollokVM-Interpreter'
}

{ #category : #accessing }
WollokVMAtribute >> configurar: anObject [
	ast := anObject
]

{ #category : #accessing }
WollokVMAtribute >> expresionInicial [
	^ ast right
]

{ #category : #accessing }
WollokVMAtribute >> identificador [
	^ identificador
]

{ #category : #accessing }
WollokVMAtribute >> identificador: anObject [
	identificador := anObject
]

{ #category : #accessing }
WollokVMAtribute >> tieneValoInicial [
	^ self expresionInicial notNil
]
