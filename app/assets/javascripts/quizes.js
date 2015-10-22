$(function(){
  if( $("#answer_string").length ){
    $("#answer_string").focus();
    $("#answer_string").keyup(function(e) {
      var correct = $("#correct").text();
      var answer = $("#answer_string").val();
      var index = correct.indexOf(answer);
      var solution = $("#solution").text();
      var kuk;
      while((index >= 0) && (answer.length > 0)){
        kuk = solution.substring(0,index) + answer + solution.substring(index+answer.length,solution.length);
        $("#solution").text(kuk);
        index = correct.indexOf(answer,index+1);
        solution = $("#solution").text();
      }
      if(correct == solution){
        //$("form").submit();
        $("audio").trigger("play");
        $("#reading").removeClass("white");
      }
    });
  }
});
