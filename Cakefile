{exec} = require 'child_process'
Rehab = require './lib/rehab'

task 'build', 'Build riff-designer using Rehab', sbuild = ->
  console.log "Building project from src/ to static/js/script.js"

  files = new Rehab().process './src'

  to_single_file = "--join static/js/script.js"
  from_files = "-bc #{files.join ' '}"

  exec "coffee #{to_single_file} #{from_files}", (err, stdout, stderr) ->
    throw err if err

task 'watch', 'Watch riff-designer files and compile using Rehab', sbuild = ->
  console.log "Watching coffee-script from src/ to static/js/script.js"

  files = new Rehab().process './src'

  to_single_file = "--join static/js/script.js"
  from_files = "-bcw #{files.join ' '}"

  exec "coffee #{to_single_file} #{from_files} ", (err, stdout, stderr) ->
    throw err if err