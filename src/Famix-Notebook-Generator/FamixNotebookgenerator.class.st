"
To generate the entities : `FamixNotebookGenerator generate`

See : https://modularmoose.org/developers/create-new-metamodel/
"
Class {
	#name : 'FamixNotebookGenerator',
	#superclass : 'FamixBasicInfrastructureGenerator',
	#instVars : [
		'notebook',
		'cell',
		'textCell',
		'codeCell',
		'output',
		'pythonEntity',
		'pythonModel'
	],
	#category : 'Famix-Notebook-Generator',
	#package : 'Famix-Notebook-Generator'
}

{ #category : 'accessing' }
FamixNotebookGenerator class >> packageName [

	^ #'Famix-Notebook-Entities'
]

{ #category : 'accessing' }
FamixNotebookGenerator class >> prefix [

	^ #FamixNotebook
]

{ #category : 'accessing' }
FamixNotebookGenerator class >> submetamodels [

	^ { FamixPythonGenerator }
]

{ #category : 'definition' }
FamixNotebookGenerator >> defineClasses [

	super defineClasses.

	cell := builder newAbstractClassNamed: #Cell.
	textCell := builder newClassNamed: #TextCell.
	codeCell := builder newClassNamed: #CodeCell.
	output := builder newClassNamed: #Output.

	"remote"
	pythonEntity := self remoteEntity: #Entity withPrefix: #FamixPython.
]

{ #category : 'definition' }
FamixNotebookGenerator >> defineHierarchy [

	super defineHierarchy.

	codeCell --|> cell.
	codeCell --|> #TSourceEntity.
	
	textCell --|> cell.
	textCell --|> #TSourceEntity.

]

{ #category : 'definition' }
FamixNotebookGenerator >> defineProperties [

	super defineProperties.
	
	cell property: #id type: #String.
	cell property: #metadata type: #Object.
	
	textCell property: #isMarkdown type: #Boolean.
	textCell property: #content type: #String.
	
	codeCell property: #executionCount type: #Number.
	codeCell property: #cellId type: #Number.
	
	output property: #metadata type: #Object.
	output property: #data type: #Object.
	output property: #output_type type: #String.
	"We have another execution count in output should check what it is"
	
	
]

{ #category : 'definition' }
FamixNotebookGenerator >> defineRelations [

	super defineRelations.
	
	codeCell -* pythonEntity.
	codeCell - output. 
	"Apparently some output are a list of entitties, should take a look"
]
