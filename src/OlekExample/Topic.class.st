Class {
	#name : #Topic,
	#superclass : #Object,
	#instVars : [
		'title'
	],
	#category : #OlekExample
}

{ #category : #accessing }
Topic class >> title: aString [
	^ self new
	title: aString;
	yourself
]

{ #category : #accessing }
Topic >> title [

	^ title
]

{ #category : #accessing }
Topic >> title: anObject [

	title := anObject
]
