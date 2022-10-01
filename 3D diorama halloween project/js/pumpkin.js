'use strict';



let $window = $( window );
let $scene = $( '.scene' );

let rX = 0;
let rY = 0;

$window.on( 'mousedown', function() {
    $window.on ('mousemove', rotateScene);  
} );

$window.on( 'mouseup', function(){
    $window.off( 'mousemove', rotateScene );
    
} );

const rotateScene = function ( event ){
    rY += event.originalEvent.movementX /2;
    rX -= event.originalEvent.movementY /2;
    $scene.css( 'transform', 'rotateX('+ rX +'deg) rotateY( '+ rY +'deg)' );
    
}

$('.face' ).prop( 'draggable', false);
$('.left' ).prop( 'draggable', false);
$('.back' ).prop( 'draggable', false);
$('.floor' ).prop( 'draggable', false);


























