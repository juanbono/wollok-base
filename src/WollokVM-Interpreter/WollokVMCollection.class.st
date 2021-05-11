Class {
	#name : #WollokVMCollection,
	#superclass : #WollokVMLiteral,
	#category : #'WollokVM-Interpreter'
}

{ #category : #accessing }
WollokVMCollection >> literalValue [
	"comment stating purpose of instance-side message"
	"scope: class-variables  &  instance-variables"	
			
"	^literalValue collect: [ :v | v literalValue ]
"	^literalValue 
]
