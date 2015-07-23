noflo = require 'noflo'

url = ""

exports.getComponent = ->
  c = new noflo.Component

  domain = "wss://ws.devicehub.net:7890/ws/v2/"
  base = domain + "project/:project/device/:device/sensor/:sensor/data"

  @inPorts = new noflo.InPorts
    project:
      datatype: 'all'
    match:
      datatype: 'object'
      description: 'Dictionnary object with key matching
         the input object and value being the replacement item'


  c.inPorts.add 'project', (event, payload) ->
    return unless event is 'data'
    c.outPorts.out.send payload

  c.inPorts.add 'device', (event, payload) ->
    return unless event is 'data'
    c.outPorts.out.send payload

  c.inPorts.add 'sensor', (event, payload) ->
    return unless event is 'data'
    c.outPorts.out.send payload


  c.outPorts.add 'out'
  c