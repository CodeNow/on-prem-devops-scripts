#!/usr/bin/env node
var MAIN_HOST_IP = '10.4.0.200'
var SWARM_PORT = '65250'

var exec = require('child_process').exec
var isIp = require('net').isIP

var tls = "--tls --tlscacert=/opt/ssl/docker/api-worker/ca.pem"
tls += " --tlskey=/opt/ssl/docker/api-worker/key.pem"
tls += " --tlscert=/opt/ssl/docker/api-worker/cert.pem"

var command = "ssh " + MAIN_HOST_IP + " 'sudo DOCKER_HOST=0.0.0.0:" + SWARM_PORT
command += " docker " + tls + " info 2> /dev/null "
command += "| grep \":4242\" --color=never'"

exec(command, (error, stdout, stderr) => {
  var ipMatch = /\b(?:[0-9]{1,3}\.){3}[0-9]{1,3}\b/i
  var orgIdMatch = /\.([0-9]*)\:/i
  var rawIps = stdout
    .split("\n")
    .map(ip => ip.match(ipMatch))
    .filter(x => !!x)
    .filter(isIp)
  var ips = rawIps.map(x => x[0])
  var hostVars = rawIps.reduce((acc, val) => {
    var ip = val[0]
    var id = val.input.match(orgIdMatch)
    acc[ip] = { host_tags: 'build,run' }
    if (id && id[1]) {
      acc[ip].host_tags = id[1]  + ',' + acc[ip].host_tags
    }
    return acc
  }, {})
  console.log(JSON.stringify({ docks: { hosts: ips }, _meta: { hostvars: hostVars }}))
})
