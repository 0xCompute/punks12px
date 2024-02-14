require 'pixelart'

## update fam composite via /ethscribe images


ids  = [
    59, 61, 62, 63, 68, 69, 70, 71, 72, 73,
    77, 80
]

cols = 5
rows = ids.size / cols 
rows += 1    if ids.size % cols != 0
fam = ImageComposite.new( cols, rows, height: 12, width: 12 )


ids.each do |id|
    fam << Image.read( "./pork/ethscribe/pork#{id}.png" )
end

fam.save( "./tmp/pork_mints.png" )
fam.zoom(4).save( "./tmp/pork_mints@4x.png" )


puts "bye"