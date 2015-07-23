noflo = require 'noflo'

composeUrl = (data) ->
  domain = 'wss://ws.devicehub.net:7890/ws/v2/'
  pattern = 'project/:project/device/:device/sensor/:sensor/data'

  domain + (pattern
  .split(':project').join(data.project)
  .split(':device').join(data.device)
  .split(':sensor').join(data.sensor))

class SensorUrl extends noflo.Component

  icon: 'at'
  description: 'Sensor web-socket URL generator'

  constructor: ->
    @inPorts = new noflo.InPorts
      project:
        datatype: 'string'
        description: 'The id of the project'
        required: true
      device:
        datatype: 'string'
        description: 'The id of the device'
        required: true
      sensor:
        datatype: 'string'
        description: 'Named identifier of sensor'
        required: true

    @outPorts = new noflo.OutPorts
      url:
        datatype: 'string'

    noflo.helpers.WirePattern(@,
      {
        "in": ['project', 'device', 'sensor'],
        out: 'url'
      },
    (data, groups, out) -> out.send(composeUrl(data))
    )

exports.getComponent = -> new SensorUrl