class FinancicalPeriodSelector

  constructor: (el) ->
    @$el = $(el)
    @bindings()

  bindings: =>
    @$el.on 'click', (e) =>
      e.preventDefault()
      new FinancicalPeriodSelectorView $(e.currentTarget).offset()

class FinancicalPeriodSelectorView
  config:
    ui:
      datepickerBeginSelector: '[role=datepicker-begin]'
      datepickerEndSelector: '[role=datepicker-end]'
      periodContainerSelector: '[role=financical-period-selector-container]'
      okButtonSelector: '[role=financical-period-ok-button]'
      periodCloseButton: '[role=financical-period-close-button]'

    periodTypeValues:
      year: 'Год'
      quarter: 'Квартал'
      month: 'Месяц'
      day: 'День'

  constructor: (containerOffSets) ->
    @$body = $('body')
    @dateBegin = new Date()
    @dateEnd = new Date()
    @$containerOffSets = containerOffSets
    @render()
    @bindings()
    @setPeriodValue('year', @dateBegin)

  render: () =>
    @$body.append @form()
    $(@config.ui.periodContainerSelector).css
      top: @$containerOffSets.top + 24,
      left: @$containerOffSets.left

  bindings: =>
    $(@config.ui.periodCloseButton).on 'click', (e) =>
      $(@config.ui.periodContainerSelector).remove()

    # Event bindings for up, down keys and radio button
    for key,val of @config.periodTypeValues
      $("##{key}_up").on 'click', (e) =>
        dataKey = $(e.currentTarget).data('keyname')
        @changePeriod dataKey, 1
        $("#period_#{dataKey}_radio").prop('checked', 'checked')

      $("##{key}_down").on 'click', (e) =>
        dataKey = $(e.currentTarget).data('keyname')
        @changePeriod dataKey, -1
        $("#period_#{dataKey}_radio").prop('checked', 'checked')

      $("#period_#{key}_radio").on 'click', (e) =>
        target = $(e.currentTarget)
        dataKey = target.data('keyname')
        splittedDate = target.data('perioddate')
        unless dataKey == 'day'
          date = new Date(splittedDate).clearTime()
        else
          date = Date.parse $("#period_#{dataKey}_text").val()
        @setPeriodValue dataKey, date

    $(@config.ui.okButtonSelector).on 'click', (e) =>
      $(@config.ui.datepickerBeginSelector).val @dateBegin.toString('dd-MM-yyyy')
      $(@config.ui.datepickerEndSelector).val @dateEnd.toString('dd-MM-yyyy')
      $(@config.ui.periodContainerSelector).remove()

  form: =>
    """
      <div class='financical-period-selector-container' role=financical-period-selector-container>
        <div class='financical-period-selector-header'>
          <span>
            <a href='#' role=financical-period-close-button> x </a>
          </span>
        </div>
        <div class='financical-period-selector-body'>
          <ui>
            #{@renderPeriodInputTags()}
          </ui>
        </div>
        <div class='financical-period-selector-footer'>
          <a href='#' role=financical-period-ok-button > ОК </a>
        </div>
      </div>
    """

  renderPeriodInputTags: =>
    str = ''
    for key,val of @config.periodTypeValues
      str =
      """
        #{str}
        <li>
          <input type='radio' name='period_type' id='period_#{key}_radio' data-perioddate='#{@dateBegin}' data-keyname='#{key}' #{@setDefaultValueToRadioInput(key)}/>
          <label for='period_#{key}_radio'> #{val} </label>
          <input type='text' id='period_#{key}_text' value='#{@getPeriodText(key, @dateBegin)}' #{@setReadOnlyForDayInput(key)}/>
          <button type='button' id='#{key}_down' data-keyname='#{key}' title='Уменьшить'>
            <img src='#{image_path('arrow_down.gif')}' />
          </button>
          <button type='button' id='#{key}_up' data-keyname='#{key}' title='Увеличить'>
            <img src='#{image_path('arrow_up.gif')}' />
          </button>
        </li>
      """
    str

  setDefaultValueToRadioInput: (name) =>
    return "value='' checked='checked'" if name == 'year'
    ''

  setReadOnlyForDayInput: (name) =>
    return "readonly" unless name == 'day'
    ''

  changePeriod: (name, direction) =>
    splittedDate = $("#period_#{name}_radio").data('perioddate')
    switch name
      when 'year'
        date = new Date(splittedDate).add(direction).year().clearTime()
        @setPeriodValue(name, date)
      when 'quarter'
        date = new Date(splittedDate).add(3 * direction).months()
        @setPeriodValue(name, date)
      when 'month'
        date = new Date(splittedDate).add(direction).month()
        @setPeriodValue(name, date)
      when 'day'
        date = new Date(splittedDate).add(direction).day()
        @setPeriodValue(name, date)
    $("#period_#{name}_radio").data('perioddate', date.toString())
    $("#period_#{name}_text").val @getPeriodText(name, date)

  setPeriodValue: (periodName, date) =>
    switch periodName
      when 'year'
        @dateBegin = date.clone().add(date.getMonth()*-1).months().moveToFirstDayOfMonth()
        @dateEnd = @dateBegin.clone().add(11-@dateBegin.getMonth()).months().moveToLastDayOfMonth()
      when 'quarter'
        @dateEnd = new Date(date.getFullYear(), @getQuarterNumberFromDate(date)*3-1, 1).moveToLastDayOfMonth()
        @dateBegin = @dateEnd.clone().add(-2).months().moveToFirstDayOfMonth()
      when 'month'
        @dateBegin = date.clone().moveToFirstDayOfMonth()
        @dateEnd = date.clone().moveToLastDayOfMonth()
      when 'day'
        @dateBegin = date.clone()
        @dateEnd = date.clone()

  getPeriodText: (name, date) =>
    switch name
      when 'year' then "#{date.getFullYear()} г."
      when 'quarter' then @getQuarterStringFromDate date
      when 'month' then @getRusMonthNameByDate date
      when 'day' then date.toLocaleFormat('%d.%m.%Y')

  getQuarterNumberFromDate: (date) =>
    currentMonth = date.getMonth() + 1
    for m in [currentMonth..12]
      if currentMonth % 3 == 0
        currentQuarter = currentMonth / 3
        break
    currentQuarter

  getQuarterStringFromDate: (date) =>
    "#{@getQuarterNumberFromDate(date)} квартал #{date.getFullYear()} г."

  getRusMonthNameByDate: (date) =>
    months = [ 'Январь', 'Февраль', 'Март', 'Апрель', 'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь' ]
    "#{months[date.getMonth()]} #{date.getFullYear()} г."

$(document).ready ->
  new FinancicalPeriodSelector('[role=open-financical-period-selector]')
