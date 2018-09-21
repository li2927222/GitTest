$(function(){
    

// ------------新闻样式

    $(".news .tab ul li").on("touchstart",function(){
        $(this).css({background:"#548903",color:"#fff"}).siblings().css({background:"#b0b0b0",color:"black"});
        var index=$(this).index();
        $(".news .cont li").eq(index).css({display:"block"}).siblings().css({display:"none"});
    });
    
});