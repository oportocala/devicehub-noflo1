noflo = require 'noflo'

composeUrl = (data) ->
  domain = 'https://api.devicehub.net/v2/'
  pattern = 'project/:project/device/:device/actuator/:actuator/state'

  domain + (pattern
  .split(':project').join(data.project)
  .split(':device').join(data.device)
  .split(':actuator').join(data.actuator))

class ActuatorStateSetUrl extends noflo.Component

  icon: 'at'
  description: 'Actuator state set URL generator'

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
      actuator:
        datatype: 'string'
        description: 'Named identifier of actuator'
        required: true

    @outPorts = new noflo.OutPorts
      url:
        datatype: 'string'

    noflo.helpers.WirePattern(@,
      {
        "in": ['project', 'device', 'actuator'],
        out: 'url'
      },
    (data, groups, out) -> out.send(composeUrl(data))
    )

exports.getComponent = -> new ActuatorStateSetUrl