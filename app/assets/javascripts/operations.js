//TODO refactor with joining codes
$(document).ready(function(){
  $(document).on('change', '#operation_category_id', function(){
    var current_category_value = this.value;
    $.get('/operations/fill_subcategory.json', {category_id: current_category_value})
      .done(function(data){
        $('#operation_subcategory_id').html('');
        $.each(data.subcategories, function(index, item){
          $('#operation_subcategory_id').append('<option value = '+item[1]+'>'+item[0]+'</option>');
        });
        $('#operation_subcategory_id').animate({opacity: .5}, 600);
        $('#operation_subcategory_id').animate({opacity: 1}, 1000);
      });
  });

  $(document).on('change', '#filter_category', function(){
    var current_category_value = this.value;
    $.get('/operations/fill_subcategory.json', {category_id: current_category_value, filter_action: true})
      .done(function(data){
        $('#filter_subcategory').html('');
        $.each(data.subcategories, function(index, item){
          $('#filter_subcategory').append('<option value = '+item[1]+'>'+item[0]+'</option>');
        });
        $('#filter_subcategory').animate({opacity: .5}, 600);
        $('#filter_subcategory').animate({opacity: 1}, 1000);
      });
  });

});
