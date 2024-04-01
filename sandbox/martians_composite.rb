require 'pixelart'

## update fam composite via /ethscribe images


recs = read_csv( './martians/mint.csv' )


cols = 10
rows = recs.size / cols 
rows += 1    if recs.size % cols != 0
punks = ImageComposite.new( cols, rows, height: 12, width: 12 )

recs.each do |rec|
    id = rec['ref'].to_i(10)
    num = '%03d' % id
    punks << Image.read( "./martians/ethscribe/martian#{num}.png" )
end

punks.save( "./tmp/martians_mints.png" )
punks.zoom(4).save( "./tmp/martians_mints@4x.png" )


puts "bye"