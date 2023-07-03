Class {
	#name : #EllipsesTopics,
	#superclass : #RSAbstractContainerBuilder,
	#instVars : [
		'colorPalette',
		'topics'
	],
	#category : #OlekExample
}

{ #category : #'instance creation' }
EllipsesTopics class >> openInspector [
	<script>
	| builder |
	builder := self new.
	builder build.
	builder canvas inspect
]

{ #category : #'instance creation' }
EllipsesTopics class >> openWindow [
	<script>
	self new open
]

{ #category : #hooks }
EllipsesTopics >> createEllipseFor: aTopic [
	| solidColor |
	solidColor := colorPalette scale: aTopic.
	^ RSEllipse new
		model: aTopic;
		color: (solidColor alpha: 0.4);
		border: (RSBorder new width: 1; color: solidColor);
		extent: self ellipseExtent;
		position: 0@0;
		"draggable;"
		yourself
]

{ #category : #hooks }
EllipsesTopics >> createEllipses [
	| initialAngle angleSpace |
	initialAngle := 135.
	angleSpace := 90.
	^ topics collectWithIndex: [ :each :index | 
		| ellipse radius angle |
		ellipse := self createEllipseFor: each.
		radius := ellipse width / 4.
		angle := (initialAngle + (angleSpace * index)) degreesToRadians.
		ellipse propertyAt: #angle put: angle.
		ellipse translateTo: angle cos @ angle sin * radius.
		ellipse rotateByRadians: angle
		 ].
]

{ #category : #hooks }
EllipsesTopics >> createLabelsFrom: ellipses [
	| labelBuilder |
	labelBuilder := RSMultilineLabelBuilder new.
	labelBuilder layout alignCenter.
	labelBuilder labelShape fontFamily: 'Arial'.
	labelBuilder wrapStrategy: (RSWrapStrategy new wrapMaxWidth: 170).
	^ ellipses collect: [ :each | | radius angle text label |
		radius := each baseRectangle width * 0.60.
		angle := each propertyAt: #angle.
		text := each model title.
		label := labelBuilder shapeFor: text.
		label scaleBy: 1.1.
		label position: angle cos @ angle sin * radius.
		label
		 ].
]

{ #category : #'accessing - defaults' }
EllipsesTopics >> defaultContainer [
	^ RSCanvas new @ RSCanvasController
]

{ #category : #initialization }
EllipsesTopics >> defaultTopics [
	^ { Topic title: 'Dynamique des pratiques, des appartenances et des paysages'.
	Topic title: 'Ethique et justice environmentales'.
	Topic title: 'Gouvernance de la nature et des ressources'.
	Topic title: 'Construction et usages des savoirs sur l''environnement'. }
]

{ #category : #hooks }
EllipsesTopics >> ellipseExtent [
	^ 250@120
]

{ #category : #initialization }
EllipsesTopics >> initialize [
	super initialize.
	colorPalette := NSScale ordinal 
		range: ({'395723'. '002060'. 'c09003'. 'c55a12'} 
			collect: [:each | Color colorFrom: each ]).
	self topics: self defaultTopics.
]

{ #category : #hooks }
EllipsesTopics >> renderIn: aCanvas [
	| ellipses labels |
	ellipses := self createEllipses.
	labels := self createLabelsFrom: ellipses.
	aCanvas addAll: ellipses; addAll: labels.
]

{ #category : #accessing }
EllipsesTopics >> topics [

	^ topics
]

{ #category : #accessing }
EllipsesTopics >> topics: anObject [

	topics := anObject
]
