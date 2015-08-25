class Operations
  constructor: ->
    @bindings()

  bindings: ->
    @datePickerBinding()
    @categorySelectBind()

  datePickerBinding: ->
    arr = ['[role=datepicker]', '[role=datepicker-begin]', '[role=datepicker-end]']
    $.each arr, (index, valueSelector) ->
      el = $(valueSelector).datepicker({format: 'dd-mm-yyyy'})
        .on 'changeDate', ->
          el.hide()
        .data 'datepicker'

  categorySelectBind: ->
    el = $('[role=category]')
    elSubcategory = $('[role=subcategory]')
    el.on 'change', ->
      $.get('/operations/fill_subcategory.json', {category_id: el.val(), filter_action: el.data('filter')})
        .done (data) ->
          elSubcategory.html ''
          $.each data.subcategories, (index, item) ->
            elSubcategory.append "<option value = #{item[1]}>#{item[0]}</option>"
          elSubcategory.animate {opacity: 0.5}, 600
          elSubcategory.animate {opacity: 1}, 1000

$(document).ready ->
  new Operations()
