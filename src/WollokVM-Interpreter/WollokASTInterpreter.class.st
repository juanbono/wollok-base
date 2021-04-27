Class {
	#name : #WollokASTInterpreter,
	#superclass : #Object,
	#instVars : [
		'bindings',
		'referencias',
		'ambienteActual',
		'ambiente',
		'debeRetornar',
		'metodoActual',
		'objetoActual'
	],
	#category : #'WollokVM-Interpreter'
}

{ #category : #'as yet unclassified' }
WollokASTInterpreter class >> baseClassName [
	"comment stating purpose of class-side message"
	"scope: class-variables  &  class-instance-variables"	
			
	^'wollok.lang.Object' 
]

{ #category : #bindings }
WollokASTInterpreter >> addBinding: aName value: aWollokVMClass [ 
	
	bindings at: aName put: aWollokVMClass
]

{ #category : #bindings }
WollokASTInterpreter >> addBindingOfClass: aName fromString: aString [

	WollokReducedLoader new addBindingOfClass: aName fromString: aString in: self
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> ambienteActual [ 
	^ambienteActual
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> ambienteActual: aWollokVMAmbiente [ 
	ambienteActual := aWollokVMAmbiente
]

{ #category : #accessing }
WollokASTInterpreter >> debeRetornar [
	^ debeRetornar
]

{ #category : #accessing }
WollokASTInterpreter >> debeRetornar: anObject [
	debeRetornar := anObject
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> ejecutar: metodo con: argumentos sobre: receptor [

|nuevoAmbiente resultado argumentosEvaluados|

argumentosEvaluados := argumentos collect: 
		[ :arg | arg acceptVisitor: self].
	
metodoActual := metodo.

nuevoAmbiente := WollokVMAmbiente new 
	ambienteMayor: receptor ambiente;
	ambienteAnterior: self ambienteActual;
	yourself.
self ambienteActual: nuevoAmbiente.

metodo argumentos values with: argumentosEvaluados do:[ :arg :value | 
	self ambienteActual agregarReferencia: (arg acceptVisitor: self) inicializadaEn: value ].


resultado := metodo nativo 
	ifFalse: [metodo ast acceptVisitor: self]
	ifTrue: [self ejecutarNativo: metodo con: argumentosEvaluados sobre:receptor].

self ambienteActual: (self ambienteActual ambienteAnterior).

^ resultado 
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> ejecutarNativo: metodo con: argumentos sobre: receptor [
|nativo resultado|
nativo := metodo buscarNativo.

resultado := nativo ejecutarCon: (argumentos collect:[:a | a literalValue]) sobre: receptor literalValue.

^ self wollokLiteralFrom: resultado class: nativo claseRetorno   
]

{ #category : #interpreting }
WollokASTInterpreter >> initialize [

	super initialize.

	bindings := Dictionary new.
	ambiente := WollokVMAmbiente new.
	ambienteActual := ambiente.

	debeRetornar := false.
	
	WollokReducedLoader new loadInto: self
]

{ #category : #interpreting }
WollokASTInterpreter >> interpretProgram: aFileNode [ 

	| lastValue |

	aFileNode main elements do: [ :e | lastValue := e acceptVisitor: self ].

	^ lastValue	
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> isFalse: object [

^ object literalValue = false
 




]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> isNull: anWollokVMObject [ 
	^anWollokVMObject isNil.
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> isTrue: object [

^ object literalValue = true
 




]

{ #category : #bindings }
WollokASTInterpreter >> lookUp: selector desde: clase [
	
	(clase tieneMetodo: selector) 
		ifTrue: [ ^ clase obtenerMetodo: selector ].
	(clase tieneSuperClase)	
		ifFalse: [ ^ nil ].
"	^ self lookUp: selector desde: (self resolve: (clase superClase)) "	
		^ self lookUp: selector desde: (self resolve: (clase superClase))

]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> objetoActual [
	^ objetoActual
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> objetoActual: aWollokVMObject [ 
	objetoActual := aWollokVMObject
]

{ #category : #bindings }
WollokASTInterpreter >> resolve: aString [ 
	
	^ bindings at: aString
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> todosLosAtributosDe: aWollokVMClass [ 
	
	^aWollokVMClass superClase 
		ifNil: [ aWollokVMClass atributos] 
		ifNotNil: [ aWollokVMClass atributos , (self todosLosAtributosDe: (self resolve: aWollokVMClass superClase) ) ] 
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitAssignment: aWollokAssignmentNode [ 
	self ambienteActual
		asignarA: aWollokAssignmentNode variable identificador 
		elValor: (aWollokAssignmentNode value acceptVisitor: self)
		 
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitBinaryOperation: aWollokBinaryOperationNode [ 
| receptor selector resultado metodo objetoAnterior|

"
operations := 	{
	'>' -> [ :a :b | a > b ].
	'<' -> [ :a :b | a < b ].
	'*' -> [ :a :b | a * b ].
	'-' -> [ :a :b | a - b ].
	'/' -> [ :a :b | a / b ].
	'+' -> [ :a :b | a + b ].
	'&&' -> [ :a :b | a & b ].
	'||' -> [ :a :b | a | b ].
	'++' -> [ :a :b | a , b ].
	'%' -> [ :a :b | a % b ].
	'==' -> [ :a :b | a = b ]
		} asDictionary.

classNames := {
	'>' -> 'Boolean'.
	'<' -> 'Boolean'.
	'*' -> 'Number'.
	'-' -> 'Number'.
	'+' -> 'Number'. 
	'/' -> 'Number'.
	'&&' -> 'Boolean'.
	'||' -> 'Boolean'.
	'%' -> 'Number'.
	'++' -> 'String'.
	'==' -> 'Number'  
	} asDictionary .
"
receptor := aWollokBinaryOperationNode leftOperand acceptVisitor: self.
"argumento := aWollokBinaryOperationNode rightOperand acceptVisitor: self."
selector :=  aWollokBinaryOperationNode selector.

	objetoAnterior := self objetoActual.
	self objetoActual: receptor.
	
metodo := self lookUp: selector desde: receptor wollokClass.
resultado := self ejecutar: metodo con: {aWollokBinaryOperationNode rightOperand} sobre: receptor.

"metodo nativo 
	ifTrue: [ resultado := self ejecutarNativo: metodo buscarNativo con: #(aWollokBinaryOperationNode rightOperand) sobre: receptor]
	ifFalse: [  ]
result := (operations at: aWollokBinaryOperationNode operation value) 
	value: left literalValue value: right literalValue.
className := classNames at: aWollokBinaryOperationNode operation value.
"
self objetoActual: objetoAnterior.
^ resultado
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitBlockExpression: aWollokBlockExpressionNode [ 
| resultado |
	aWollokBlockExpressionNode expressions do:
		[ :exp | resultado := exp acceptVisitor: self.
					self debeRetornar ifTrue: [ ^resultado ] ].
	^nil
]

{ #category : #visiting }
WollokASTInterpreter >> visitBooleanLiteral: aWollokBooleanLiteralNode [ 

	^ self wollokBooleanFrom: aWollokBooleanLiteralNode value value = 'true'
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitConstructorCall: aWollokConstructorCallNode [ 
	|instancia  clase metodoInitialize "ambienteAnterior"|
	
	clase := self resolve: (aWollokConstructorCallNode classRef acceptVisitor: self).
	
	instancia := WollokVMObject new
		wollokClass: clase;
		ambiente: (WollokVMAmbiente new 
						ambienteMayor: ambiente;
						ambienteAnterior: self ambienteActual;
						yourself)
		yourself.
	
	(self todosLosAtributosDe:clase) do: [:atr | 
		instancia 
			inicializarAtributo: (atr identificador) 
			conValor: (atr expresionInicial 
								ifNil: [ nil ] 
								ifNotNil: [atr expresionInicial  acceptVisitor:self ]).
	].
	"REVISAR"
	"instancia setearAtributosRecibidos: aWollokConstructorCallNode argumentos."
	metodoInitialize := self lookUp: 'initialize0' desde: instancia wollokClass.
	metodoInitialize 
		ifNotNil: [ 	
			"ambienteAnterior := self ambienteActual.
			self ambienteActual: instancia ambiente. "
			self ejecutar: metodoInitialize con: #() sobre: instancia ].
			"self ambienteActual: ambienteAnterior."
	^instancia

]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitIfExpression: aWollokIfExpressionNode [ 
	| result condition |
	condition := aWollokIfExpressionNode condition acceptVisitor: self.
result := condition literalValue
	ifTrue: [   aWollokIfExpressionNode then acceptVisitor: self] 
	ifFalse: [   aWollokIfExpressionNode else acceptVisitor: self]. 
^ result
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitListLiteral: aWollokListLiteralNode [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitMemberFeatureCall: aWollokMemberFeatureCallNode [ 
	| selector receptor metodo resultado objetoAnterior|
	
	receptor := aWollokMemberFeatureCallNode receiver acceptVisitor: self.
	"Ver cantidad de argumentos para elegir selector"
	
	objetoAnterior := self objetoActual.
	self objetoActual: receptor.
	
	selector := aWollokMemberFeatureCallNode selector.
	metodo := self lookUp: selector desde: receptor wollokClass.

	resultado := self ejecutar: metodo con: aWollokMemberFeatureCallNode arguments sobre: receptor.

	self objetoActual: objetoAnterior.
	
	^resultado
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitMethodDeclaration: aWollokMethodDeclarationNode [ 
"Revisar Nativos  - Return - OVerride "
	"aWollokMethodDeclarationNode native ifNotNil: [  ]."
	^ aWollokMethodDeclarationNode expression acceptVisitor: self
]

{ #category : #visiting }
WollokASTInterpreter >> visitNumberLiteral: aWollokNumberLiteralNode [ 

	^ self wollokNumberFrom: aWollokNumberLiteralNode numberValue
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitParameter: aWollokParameterNode [ 
	^aWollokParameterNode parameter value
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitProgram: aWollokProgramNode [ 
	
	^self.
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitQualifiedName: aWollokQualifiedNameNode [ 
	^ aWollokQualifiedNameNode asWollokQualifiedName .
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitReturnExpression: aWollokReturnExpressionNode [ 
	self debeRetornar: true.
	^ aWollokReturnExpressionNode expression acceptVisitor: self.
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitSelf: aWollokSelfNode [ 
	^objetoActual.
]

{ #category : #visiting }
WollokASTInterpreter >> visitStringLiteral: aWollokStringLiteralNode [ 

	^ self wollokLiteralFrom: aWollokStringLiteralNode stringValue class: 'String'
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitSuperInvocation: aWollokSuperInvocationNode [ 
	|superClase|
	superClase := self resolve: (metodoActual superClase).
	metodoActual := self lookUp: metodoActual selector desde: superClase.
	^self ejecutar: metodoActual con: aWollokSuperInvocationNode arguments sobre: objetoActual
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitUnaryOperation: aWollokUnaryOperationNode [ 
| right result operations className classNames|

operations := 	{
	'-' -> [ :a | -1 * a ].
	'not' -> [ :a | a not ]
	} asDictionary.

classNames := {
	'-' -> 'Number'.
	'not' -> 'Boolean'
	} asDictionary .
	
right := aWollokUnaryOperationNode rightOperand acceptVisitor: self.

result := (operations at: aWollokUnaryOperationNode operation value) 
	value: right literalValue.
className := classNames at: aWollokUnaryOperationNode operation value.
^ self wollokLiteralFrom: result class:className
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitVariable: aWollokVariableNode [ 
	^self ambienteActual resolverReferencia: aWollokVariableNode identificador
]

{ #category : #'as yet unclassified' }
WollokASTInterpreter >> visitVariableDeclaration: aWollokVariableDeclarationNode [ 

	"self buscarAmbiente: aWollokVariableDeclarationNode."
	self ambienteActual agregarReferencia: (aWollokVariableDeclarationNode identificador ) 
		inicializadaEn: (aWollokVariableDeclarationNode right
					ifNil: [ nil ]
					ifNotNil: [aWollokVariableDeclarationNode right acceptVisitor: self]).
]

{ #category : #literals }
WollokASTInterpreter >> wollokBooleanFrom: anBoolean [
	^ WollokVMLiteral new
		wollokClass: (self resolve: 'wollok.lang.Boolean');
		literalValue: anBoolean;
		yourself
]

{ #category : #literals }
WollokASTInterpreter >> wollokLiteralFrom: aValue class: className [ 
	^ WollokVMLiteral new
		wollokClass: (self resolve: 'wollok.lang.', className);
		literalValue: aValue;
		yourself
]

{ #category : #literals }
WollokASTInterpreter >> wollokNumberFrom: anInteger [ 

	^ WollokVMLiteral new
		wollokClass: (self resolve: 'wollok.lang.Number');
		literalValue: anInteger;
		yourself
]
