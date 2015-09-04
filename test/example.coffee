createBlueprint = require '../src/generator'

if parseInt(process.argv[2],10) > 0
  console.log createBlueprint(parseInt(process.argv[2],10))
else
  console.log createBlueprint(10)
