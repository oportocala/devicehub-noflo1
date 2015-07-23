noflo = require 'noflo'

class ActuatorStateSet extends noflo.Component


  icon: 'gears'
  description: ''


  constructor: ->
    @inPorts = new noflo.InPorts
      url:
        datatype: 'string'
        description: 'The url to submit to'
        required: true
        cached: true

      key:
        datatype: 'string'
        required: true
        cached: true

      state:
        datatype: 'string'
        required: true


    @outPorts = new noflo.OutPorts
      out:
        datatype: 'string'
      error:
        datatype: 'object'


    noflo.helpers.WirePattern(@,
      {
        "in": ['url', 'key', 'state'],
        out: ['out', 'error']
      },
    (data, groups, out, error) =>
      console.log('data:', data)
      console.log(arguments)
      callback = (data) -> console.log(data) #out.send(data)
      @doAsync(data, callback)
    )

  doAsync: (data, callback) ->
    params = "{\"state\": #{data.state}}"
    req = new XMLHttpRequest
    req.open 'POST', data.url, true

    req.setRequestHeader("Content-type", "application/json")
    req.setRequestHeader("X-ApiKey", data.key)

    req.onreadystatechange = =>
      if req.readyState is 4
        if req.status is 200
          @outPorts.out.beginGroup data.url
          @outPorts.out.send req.responseText
          @outPorts.out.endGroup()
          callback()
        else
          callback new Error "Error posting to #{data.url}"

    req.send params


exports.getComponent = -> new ActuatorStateSet