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
});
