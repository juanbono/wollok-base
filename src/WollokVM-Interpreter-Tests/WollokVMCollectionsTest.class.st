Class {
	#name : #WollokVMCollectionsTest,
	#superclass : #AbstractWollokVMInterpreterTest,
	#category : #'WollokVM-Interpreter-Tests-5.Collections'
}

{ #category : #tests }
WollokVMCollectionsTest >> testAnyReturnsTheBoolean [

	| object |
	
	object := self interpretExpression: '[2, 3 , 4].any{x => x > 3}'.
	self assert: object literalValue equals: true
]

{ #category : #tests }
WollokVMCollectionsTest >> testClosureWithArguments [

	| object |
	
	object := self interpretExpression: '{x => x+1}.apply(1)'.
	self assert: object literalValue equals: 2
]

{ #category : #tests }
WollokVMCollectionsTest >> testClosureWithVariables [

	| object |
	
	object := self interpretExpression: 'var a = 1 {a+1}.apply()'.
	self assert: object literalValue equals: 2
]

{ #category : #tests }
WollokVMCollectionsTest >> testClosureWithoutArguments [

	| object |
	
	object := self interpretExpression: '{1+1}.apply()'.
	self assert: object literalValue equals: 2
]

{ #category : #tests }
WollokVMCollectionsTest >> testContainsReturnsTheBoolean [

	| object |
	
	object := self interpretExpression: '[2, 3 , 4].contains(3)'.
	self assert: object literalValue equals: true
]

{ #category : #tests }
WollokVMCollectionsTest >> testContainsReturnsTheBoolean2 [

	| object |
	
	object := self interpretExpression: 'var x = 3 [2, x , 4].contains(x)'.
	self assert: object literalValue equals: true
]

{ #category : #tests }
WollokVMCollectionsTest >> testFilterReturnsTheList [

	| object |
	
	object := self interpretExpression: 'var filtrada = [2, 3 , 4].filter{x => x > 3} filtrada.contains(3)'.
	self assert: object literalValue equals: true
]

{ #category : #tests }
WollokVMCollectionsTest >> testLiteralListIsAWollokList [

	| object |
	
	object := self interpretExpression: '[2, 3 , 4]'.
	self assert: object wollokClassName equals: 'List'
]

{ #category : #tests }
WollokVMCollectionsTest >> testMaxReturnsCorrectValue [

	| object |
	
	object := self interpretExpression: '[2, 3 , 4].max()'.
	self assert: object literalValue equals: 4
]

{ #category : #tests }
WollokVMCollectionsTest >> testSizeReturnsTheSize [

	| object |
	
	object := self interpretExpression: '[2, 3 , 4].size()'.
	self assert: object literalValue equals: 3
]
