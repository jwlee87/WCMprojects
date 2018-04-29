/**
 * 
 */

$(document).ready(function(){
  
  var slide = null;
  var slideItem = $(".slide-item");
  
  var itemArray = new Array();
  var count = 1;
  
  var beginItem = slideItem[0];
  var currentItem = null;
  var endItem = null;
  var prevItem = null;
  var nextItem = null;
  var itemLength = slideItem.length;
  
  function slideShow(){
    
    for(var i=0; i < itemLength; i++){
      itemArray[i] = slideItem[i];
      console.log("==="+i+"===");
      console.log(itemArray[i]);
      console.log(slideItem[i]);
      console.log("==="+i+"===");
    }
    
    
    
    var no = $(".slide-box").children(":visible").length;
    console.log("no="+no);
    console.log(itemLength);
    
    if(no==0){
      var last = count.length;
      prevItem = slideItem[count];
      currentItem = slideItem[count+1];
      nextItem = slideItem[count+2];
      
      console.log("+++++");
      console.log(prevItem);
      console.log(currentItem);
      console.log(nextItem);
      console.log("+++++");
    }else{
      currentItem = $(".slide-box").children(":visible");
      nextItem = slideItem;
    }
    console.log(currentItem);
    
    
    $(currentItem).fadeIn(1500);
    $(prevItem).fadeOut(1500);
    
    console.log("전: "+count);
    
    
    
    if(count==slideItem.length){
      count = 0;
    }
    
    
    
    count ++;
    console.log("후: "+count);
  }
  
  
  
  
  function slideStart(){
    slide = setInterval(function (){
      slideShow();
    }, 3000);
  };
  
  function slideStop(){
    clearInterval(slide);
  }
  
  slideStart();
  
  $(".slide-banner").mouseenter(function(){
    console.log("마우스 인");
    
    slideStop();
  }).mouseleave(function(){
    console.log("마우스 아웃");
    
    slideStart();
  });
  
});