require 'cocos'

specs = read_csv( "./presidents/presidents12px.csv" )

=begin
 {"name":"#0",
   "image":"https://live---metadata-5covpqijaa-uc.a.run.app/images/0",
    "external_url":"https://www.proof.xyz/moonbirds/0",
    "attributes":[
        {"trait_type":"Eyes","value":"Angry"},
        {"trait_type":"Outerwear","value":"Hoodie Down"},
        {"trait_type":"Body","value":"Tabby"},
        {"trait_type":"Feathers","value":"Gray"},
        {"trait_type":"Background","value":"Green"},
        {"trait_type":"Beak","value":"Small"}]
  }
=end


## random shuffle specs
# srand( 4242 )   ## make deterministic
# indexes = (0..41).to_a.shuffle
# pp indexes
indexes = [
   3, 5, 11, 7, 27, 39, 32,
  31, 18, 24, 30, 33, 6, 23,
  14, 9, 22, 1, 10, 21, 38,
  28, 26, 37, 15, 25, 36, 12,
  0, 2, 20, 4, 41, 35, 8,
  29, 19, 40, 16, 34, 17, 13]



indexes.each_with_index do |idx, i|
     rec = specs[idx]
   
     base        = rec['type']
     attributes = (rec['attributes'] || '' ).split( '/').map { |attr| attr.strip }

     item_attributes = []
     item_attributes << { 'trait_type' => 'type',
                          'value'      => base }
     attributes.each do |attr|   ## change name to attribute (from accessory)
         item_attributes << { 'trait_type' => 'attribute',
                              'value'      => attr } 
     end
  
     item_attributes <<  { 'trait_type' => 'attribute count',
                           'value' => attributes.size.to_s }  ## number (type) possible?
  
     item =  {
              'name' => "President 12px \##{i+1}",
              'image' => "https://github.com/0xCompute/punks12px/raw/master/presidents/i/president#{idx+1}.png",
              'attributes' => item_attributes
           }   
    
     write_json( "./presidents/metadata/#{i+1}", item )
end


puts "bye"


