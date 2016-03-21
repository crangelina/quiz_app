// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require ace
//= require mode-javascript
//= require mode-ruby
//= require theme-tomorrow
//= require_tree 


$(function() {

  //---------------- NEW QUIZ ------------------

  var $questionsBtn = $(".more-questions-btn");
  var $questionsWrapper = $(".more-questions-wrapper")
  var questionsIndex = 1;

  // answer_type/answer_language
  function toggleLanguageInput(type, language) {
    $(type).on('change', function() {
      var $languageType = $(this).next(language)
      var $placeholderCodeEditor = $(this).parent('.answer-fields').siblings('.placeholder-code');
      var $expectedAnswerEditor = $(this).parent('.answer-fields').siblings('.expected-answer');
      var $expectedAnswerInput = $(this).parent('.answer-fields').siblings('.real-expected-answer-input').find('input');
      if ( $(this).val() == 'Code' ) {
        $languageType.attr('disabled', false);
        $languageType.val('JavaScript');
        $placeholderCodeEditor.show();
        $placeholderCodeEditor.attr("data-language", 'JavaScript');
        $expectedAnswerEditor.show();
        $expectedAnswerEditor.addClass("notHidden");
        $expectedAnswerInput.attr("type", "hidden");
      } else {
        $languageType.attr('disabled', true);
        $languageType.val('');
        $placeholderCodeEditor.hide();
        $expectedAnswerEditor.hide();
        $expectedAnswerEditor.removeClass("notHidden");
        $expectedAnswerInput.attr("type", "text");
      }
    })
  }

  // answer_type/answer_language on page load
  toggleLanguageInput('.answer-type', '.language-type');

  // adding question inputs
  $questionsBtn.on("click", function() {
    var $html = $(JST["templates/questions-template"]({index: questionsIndex}));
    var addedLanguageInput = '.language-type-added-' + questionsIndex;
    $questionsWrapper.append($html);
    $(addedLanguageInput).val('').attr('disabled', true);
    // answer_type/answer_language on-click $questionsBtn
    toggleLanguageInput('.answer-type-added', addedLanguageInput);
    var placeholderCodeEditor = $html.find('.editor').get(0);
    var expectedAnswerEditor = $html.find('.editor').get(1);
    createEditor(placeholderCodeEditor);
    createEditor(expectedAnswerEditor);
    questionsIndex++;
  });

  // put value of ace editors in hidden fields
  $('.form-new-quiz').submit(function() {
    // placeholder code
    $('.placeholder-code-editor').each(function(i, el) {
      var editor = ace.edit(el);
      var editorValue = editor.getValue();
      var hiddenValue = $(this).parent('.field').find('.hidden-placeholder-code-field');
      hiddenValue.val(editorValue);
    })
    // expected answer
    $('.expected-answer-editor').each(function(i, el) {
      if ( $(this).parent(".expected-answer").hasClass("notHidden") ) {
        var editor = ace.edit(el);
        var editorValue = editor.getValue();
        var inputValue = $(this).parent('.expected-answer').siblings('.real-expected-answer-input').find('input');
        inputValue.val(editorValue);  
      };
    })
  })



  




  //------ ACE EDITOR ------

  $('.editor').each(function(i, el) {
    var editor = createEditor(el);

    if ( $(this).hasClass('review-editor') ) {
      editor.setReadOnly(true)
    }

  });

  function createEditor(el) {
    var editor = ace.edit(el);
    editor.setTheme("ace/theme/tomorrow");

    if ( $(this).data('language') == "JavaScript" ) {
      editor.getSession().setMode("ace/mode/javascript");
    } else {
      editor.getSession().setMode("ace/mode/ruby");
    }

    return editor;
  }




  //------ USER TAKING QUIZ ------

  // put value of ace editor in hidden field 
  $('.form-user-quiz').submit(function() {
    $('.editor').each(function(i, el) {
      var editor = ace.edit(el);
      var editorValue = editor.getValue();
      var hiddenValue = $(this).parent('.field').find('.hidden-answer-value-field');
      hiddenValue.val(editorValue);
    })
  })

  //------ TEACHER EDITING QUIZ ------



  









  





});


