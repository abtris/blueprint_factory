FactoryGirl  = require 'factory_girl'
faker        = require 'faker'
indentString = require 'indent-string'

FactoryGirl.define 'user', ->
  @id = Math.random() * 101|0
  @title = 'That\'s awesome day'
  @emotion = 'happy'

user = FactoryGirl.create 'user'

createMeta = ->
  "FORMAT: 1A\n"

createApiName = ->
  "# #{faker.name.findName()}\n"

createGroup = (size) ->
  "# Group #{faker.internet.userName()}\n"

createEndpoint = ->
  "## #{faker.address.country()} [/#{faker.internet.userName().toLowerCase()}]\n"


createResponse = (code = 200, method = 'GET') ->
  """
  ### #{faker.internet.domainWord()} [#{method}]
  + Response #{code} (application/json)

  #{createBody()}

  """

createBody = ->
  string = JSON.stringify faker.helpers.createCard(), ' ', 2
  indentString string, ' ', 8


createBlueprint = ->
  """
  #{createMeta()}
  #{createApiName()}
  #{createGroup()}
  #{createEndpoint()}
  #{createResponse()}
  """

module.exports = createBlueprint
