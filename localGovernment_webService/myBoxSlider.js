// TODO : Javascript 선택자 관련 공부...
$(document).ready(function(){
    var mySlider = $('.slider').bxSlider({
        onSliderLoad : function () {
        alert("Loaded my Slider...");
        },
        slideWidth: 300,
    });
});

alert("Loaded myBoxSlider.js");