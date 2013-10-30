{spawn} = require 'child_process'
Rehab = require './lib/rehab'

buildRiff = (watch=false) ->
  from_files = (new Rehab().process './src')
  coffee = spawn 'cmd', ["/c", "coffee", "-j", "static/js/script.js", "-bc"+(if watch then "w" else "")].concat from_files
  coffee.on 'error', (err) ->
    console.log 'coffee error', err
  coffee.stdout.on 'data', (data) -> console.log data.toString().trim()
  coffee.stderr.on 'data', (data) -> console.log data.toString().trim()

task 'build', 'Build riff-designer using Rehab', ->
  console.log "Building coffee-script from src/ to static/js/script.js"
  buildRiff()

task 'watch', 'Watch riff-designer files and compile using Rehab', ->
  console.log "Watching coffee-script from src/ to static/js/script.js"
  buildRiff(true)