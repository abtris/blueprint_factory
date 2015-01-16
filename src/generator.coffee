FactoryGirl  = require 'factory_girl'
faker        = require 'faker'
indentString = require 'indent-string'
async        = require 'async'

FactoryGirl.define 'user', ->
  @id = Math.random() * 101|0
  @title = 'That\'s awesome day'
  @emotion = 'happy'

user = FactoryGirl.create 'user'

debug = false

randomIntInc = (low, high) ->
  Math.floor(Math.random() * (high - low + 1) + low)

createMeta = ->
  "FORMAT: 1A\n"

createApiName = ->
  "# #{faker.name.findName()}\n"

createGroup = (size) ->
  output = ''
  console.log "Group Size: #{size}" if debug
  for i in [1..size]
    output += "# Group #{faker.internet.userName()}\n"
    endpointSize = Math.random()*10|0
    output += createEndpointWithResponse(endpointSize)
  output

createEndpointWithResponse = (size) ->
  output = ''
  for i in [1..size]
    output += "#{createEndpoint()}"
    output += "#{createResponse()}"
  output

createEndpoint = ->
  "## #{faker.address.country()} [/#{faker.internet.userName().toLowerCase()}]\n"

createResponse = (code = 200, method = 'GET') ->
  """
  ### #{faker.internet.domainWord()} [#{method}]
  + Response #{code} (application/json)

  #{createJsonBody()}
  \n
  """

createJsonBody = ->
  string = JSON.stringify faker.helpers.createCard(), ' ', 2
  indentString string, ' ', 8

createBody = ->
  string = faker.lorem.paragraph
  indentString string, ' ', 8

createBlueprint = ->
  groupSize = randomIntInc 1,3

  """
  #{createMeta()}
  #{createApiName()}
  #{createGroup(groupSize)}
  """

module.exports = createBlueprint
