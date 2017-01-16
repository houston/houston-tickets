$ ->

  $('body').on 'click', '[rel="ticket"]', (e)->
    return if $(e.target).closest('a').length > 0

    $link = $(@)
    number = +$link.attr('data-number')
    project = $link.attr('data-project')
    $context = $link.closest('#tickets')
    e.preventDefault() if App.showTicket(number, project, $context: $context)


  window.App.showNewTicket = (options)->
    options ?= {}
    $banner = $('.project-banner')
    slug = $banner.attr('data-project-slug')
    color = $banner.attr('data-project-color')
    if slug and $('#new_ticket_modal').length is 0
      new NewTicketModal(_.extend(options, slug: slug, color: color)).show()

  window.App.formatTicketSummary = (message)->
    message = Handlebars.Utils.escapeExpression(message)
    [feature, sentence] = message.split(':', 2)
    if sentence then "<b>#{feature}:</b>#{sentence}" else message

  window.App.showTicket = (number, project, options)->
    project = project || $('.project-banner').attr('data-project-slug')
    return false unless number and project

    options ||= {}
    options.project = project
    $context = options.$context || $('#tickets')
    numbers = _.map($context.find('[rel="ticket"]:visible'), (el)-> +$(el).attr('data-number'))
    options.ticketNumbers = numbers if numbers.length > 0
    new TicketModalView(options).show(number)
