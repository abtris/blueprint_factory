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
    output += "# Group #{faker.name.lastName()}#{i}\n"
    endpointSize = Math.random()*10|1
    output += createEndpointWithResponse(endpointSize, i)
  output

createEndpointWithResponse = (size, index) ->
  output = ''
  for i in [1..size]
    output += "#{createEndpoint(index)}"
    output += "#{createResponse(index)}"
  output

createEndpoint = (index) ->
  "## #{faker.address.country().replace('(','').replace(')', '')}#{index} [/#{faker.name.firstName().toLowerCase()}#{index}]\n"

createResponse = (index, code = 200, method = 'GET') ->
  """
  ### #{faker.internet.domainWord()}#{index} [#{method}]
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

createBlueprint = (n = 3) ->
  groupSize = randomIntInc 1, n

  """
  #{createMeta()}
  #{createApiName()}
  #{createGroup(groupSize)}
  """

module.exports = createBlueprint
