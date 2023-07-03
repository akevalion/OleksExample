Class {
	#name : #MapExample,
	#superclass : #RSAbstractContainerBuilder,
	#category : #OlekExample
}

{ #category : #'instance creation' }
MapExample class >> open [
	<script>
	self new open
]

{ #category : #'instance creation' }
MapExample class >> openInspector [
	<script>
	| b |
	b := self new.
	b build.
	b canvas inspect
]

{ #category : #'instance creation' }
MapExample class >> openTiramisu [
	<script>
	| shape c box metrics label title |
	shape := EllipsesTopics new asShape.
	shape padding: 10.
	shape color: Color blue translucent.
	shape "RSComposite".

	c := RSCanvas new.
	box := RSBox new.
	metrics := RSCairoFitMetricsProvider new.
	label := RSLabel text: 'Tiramisu'.
	"label metricsProvider: metrics."
	box extent: label extent + 5.
	RSVerticalLineLayout new
		alignCenter;
		on: { box. label }.
	RSLocation new
		outer;
		bottom;
		center;
		move: label on: box.
	title := { box. label } asShape.
	title model: 'Gelato'.
	title popup.
	title draggable.
	c add: title.
	c zoomToFit.
	c showEncompassingRectangles.
	^ c inspect
]

{ #category : #hooks }
MapExample >> bolivia [
	^ 'M295.89,286.383l-3.089,-0.127l-1.030,2.187l-1.544,-2.060l-3.477,-0.644l-2.316,2.447l-1.932,0.386l-1.028,-3.733l-1.417,-2.960l0.773,-2.576l-1.417,-1.157l-0.387,-1.933l-1.286,-1.932l1.673,-2.830l-1.158,-2.318l0.643,-0.901l-0.515,-1.029l1.159,-1.287l0,-2.317l0.128,-1.931l0.644,-0.901l-2.445,-4.248l2.060,0.127l1.415,0l0.515,-0.771l2.446,-1.160l1.416,-1.029l3.476,-0.386l-0.258,1.930l0.387,1.159l-0.258,1.802l2.960,2.317l2.962,0.515l1.030,1.030l1.801,0.515l1.159,0.772l1.673,0l1.545,0.773l0.128,1.544l0.516,0.773l0.128,1.158l-0.772,0l1.031,3.219l5.148,0.131l-0.386,1.542l0.258,1.030l1.416,0.771l0.643,1.676l-0.386,2.061l-0.772,1.158l0.257,1.544l-0.901,0.643l0,-0.902l-2.575,-1.285l-2.446,-0.130l-4.634,0.772l-1.416,2.447l0,1.414l-1.030,3.219l0.515,0.515z'
]

{ #category : #hooks }
MapExample >> createPhoto [
	| paint folder img |
	folder := (IceRepository repositories
		detect: [ :each | each name = 'OleksExample' ]) repositoryDirectory.
	img := ImageReadWriter 
		formFromFileNamed: folder / 'img'/ 'david.jpeg'.
	paint := AthensCairoPatternSurfacePaint createForSurface: (AthensCairoSurface fromForm: img).
	paint origin: img extent / -2.
	^ RSEllipse new
		size: img extent min;
		border: (RSBorder new color: Color black; width: 2);
		paint: paint;
		scaleBy: 0.1;
		draggable;
		popup;
		model: 'David';
		yourself.
]

{ #category : #'accessing - defaults' }
MapExample >> defaultContainer [
	| controller canvas |
	controller := RSCanvasController new.
	controller configuration maxScale: 100.
	canvas := RSCanvas new.
	canvas inspectorContext: RSEmptyContextInteraction new.
	^ canvas @ controller 
]

{ #category : #hooks }
MapExample >> peru [
	^ 'M277.74,274.281l-0.644,1.417l-1.415,0.644l-2.704,-1.543l-0.258,-1.031l-5.278,-2.705l-4.891,-2.959l-2.059,-1.674l-1.159,-2.188l0.515,-0.773l-2.318,-3.605l-2.703,-4.891l-2.446,-5.407l-1.158,-1.288l-0.902,-1.930l-2.058,-1.802l-1.932,-1.028l0.901,-1.161l-1.287,-2.576l0.772,-1.929l2.189,-1.673l0.386,1.030l-0.773,0.643l0,1.029l1.159,-0.257l1.030,0.388l1.159,1.286l1.545,-1.030l0.514,-1.802l1.673,-2.446l3.219,-1.030l2.961,-2.832l0.772,-1.674l-0.386,-2.059l0.772,-0.258l1.802,1.288l0.772,1.287l1.288,0.644l1.544,2.832l2.060,0.257l1.416,-0.644l1.030,0.516l1.673,-0.259l2.060,1.287l-1.802,2.704l0.772,0l1.416,1.417l-2.446,-0.129l-0.386,0.514l-2.188,0.515l-3.089,1.802l-0.129,1.288l-0.772,0.901l0.257,1.416l-1.545,0.773l0,1.158l-0.772,0.516l1.158,2.445l1.546,1.674l-0.644,1.158l1.801,0.129l1.030,1.416l2.317,0l2.317,-1.545l-0.256,4.119l1.287,0.257l1.416,-0.384l2.445,4.248l-0.644,0.901l-0.128,1.931l0,2.317l-1.159,1.287l0.515,1.029l-0.643,0.901l1.158,2.318l1.673,-2.830z'
]

{ #category : #hooks }
MapExample >> processClick: evt [
	| shape |
	shape := evt shape.
	shape model inspect.
]

{ #category : #hooks }
MapExample >> renderIn: aCanvas [

	| countries country photo |
	countries := { self bolivia. self peru } collect: [ :each | 
		country := RSSVGPath new.
		country svgPath: each.
		country draggable.
		country model: each.
		country border: (RSBorder new width: 1; color: Color black).
		country when: RSMouseClick send: #processClick: to: self.
		country color: Color random.
	].
	photo := self createPhoto.
	aCanvas addAll: countries.
	aCanvas add: photo.
]
