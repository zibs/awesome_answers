$(document).ready(function(){

  $.ajax({
    url: "http://localhost:3001/questions.json",
    method: "GET",
    error: function() {
      alert("Please reload");
    },
    success: function(questions) {
      $("#questions").html("");
      var template = $("#question-listing").html();
      for (var i = 0, q = questions.length; i < q; i++) {
        // Fetching the mustache template for a Question Listing
        // Mustache.render takes in a Mustache template and a JavaScript object, and then generates valid HTML by replacing any varaibles within {{}} from the attributes of teh object. So if we have a title in the template being rendered, the JS we pass in will launch that shit.
        var renderedHtml = Mustache.render(template, questions[i]);
        // $("#questions").append("<p>" + questions[i].title + "</p><hr>");
        $("#questions").append(renderedHtml);
      }
    }
  });

  $("#questions").on("click", "a", function() {
    $.ajax({
      url: "http://localhost:3001/questions/" + $(this).data('id') + ".json",
      method: "GET",
      error: function() {
          alert("Please reload");
      },
      success: function(question) {
        console.log(question.answers);
        // fetch the template
        var template = $("#question-details").html();
        // use template to generate HTML
        var renderedHtml = Mustache.render(template, question);
        console.log(renderedHtml);
        // insert HTML on the page
        $("#question-details-container").html(renderedHtml);
        $("#question-details-container").hide();
        $("#questions").fadeOut(400, function() {
          $("#question-details-container").fadeIn(400);
          $("#hide-answers").hide();
        });
        // show answers for question
        $("#question-details-container").on("click", "a#show-answers", function(){
          var template = $("#answer-listing").html();
          var answers = question.answers;
          $("#hide-answers").show();
          $("#show-answers").hide();
          for (var i = 0; i < answers.length; i++) {
            var renderedHtml = Mustache.render(template, answers[i] );
            $("#question-details-container").append(renderedHtml);
            // $(".answers").fadeIn(400);
          }
        });
        // hide answers
        $("#question-details-container").on("click", "a#hide-answers", function(){
          $(".answers").fadeOut(500);
          $("#hide-answers").hide();
          $("#show-answers").show();
        });

      }
    });
  });

  $("#question-details-container").on("click", "a#back", function() {
    $("#question-details-container").fadeOut(400, function() {
      $("#questions").fadeIn(400);
    });
  });


  // $("#question-details-container").on("click", "a#show-answers", function() {
  //  var questionId = $(this).data("q-id");
    // $.ajax({
      // url: "http://localhost:3000/questions" + questionId + /answers.json,
      // method: "GET",
      // success: function(answers) {
      // var template = $("#answer").html();
      // for (var i = 0; i < answers.length; i++) {
        // var renderedHtml = Mustache.render(template, answers[i]);
          // $(".answers-container").append(renderedHtml);
      // }
      // $("#show-answers").slideUp();
    // };
    // });
  // });


// end doc
});


// $("a#back").on("click", function() {
//   $("#question-details-container").fadeOut(400, function() {
//     $(this).remove();
//     $("#questions").fadeIn(400);
//   });
// });
