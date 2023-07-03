"
An EllipsesTopicsTest is a test class for testing the behavior of EllipsesTopics
"
Class {
	#name : #EllipsesTopicsTest,
	#superclass : #TestCase,
	#category : #'OlekExample-Tests'
}

{ #category : #tests }
EllipsesTopicsTest >> testOpen [
	| window |
	window := EllipsesTopics new open.
	self assert: window isDisplayed.
	window delete.
]
