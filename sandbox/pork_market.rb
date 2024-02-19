##
## for a sample
## see https://api.ethscriptions.com/api/collections/sample


require 'cocos'


meta = read_csv( './pork/pork12px.csv' )
puts "  #{meta.size} meta record(s)"


collection_items = []

(0..83).each do |i|
    num = '%02d' % i
    path = "./pork/hashcheck/#{num}.json"

    if File.exist?( path )
       data = read_json( path )

       spec = meta[ i ]
       type       = spec['type']
       attributes = (spec['attributes'] || '').split( '/' ).map {|attr| attr.strip }
    
       item_attributes = []
       item_attributes << { 'trait_type' => 'type',
                            'value'      => type }
       attributes.each do |attr|   ## change name to attribute (from accessory)
           item_attributes << { 'trait_type' => 'attribute',
                                'value'      => attr } 
       end

       item_attributes <<  { 'trait_type' => 'attribute count',
                             'value' => attributes.size.to_s }  ## number (type) possible?
   

      # for debate - what name to use?
      #   plain ->   Punk #0
      #  or          Punk 12px #0   or 
      #              Punk #0 (Punks 12px, Vol. 1 - Cassics)

       collection_items << {
                  'ethscription_id' => data['ethscription']['transaction_hash'],
                  'name' => "Pork 12px \##{i}",
                  'description' => '',
                  'external_url' => '',
                  'background_color' => '',
                  'item_index' => i,
                  'item_attributes' => item_attributes
               }
    end
end
print "\n"


##
# sample banner is 1400x350px
#  ethscribe color is #C3FF00
collection = {
  'name': 'pork12px',
  'description': 'pork12px - a punks 12px special art edition - first-is-first',
  'total_supply': '84',
  'logo_image_uri': 'esc://ethscriptions/0x003c02858f6dfe83d9ceeae8702935083aa3fcd3ba64422ea81a4d728f5a4d7d/data',
  'banner_image_uri': 'https://github.com/0xCompute/punks12px/raw/master/i/pork12px-banner.png',
  'background_color': '',
  'twitter_link': '',
  'website_link': 'https://github.com/0xCompute/punks12px',
  'discord_link': 'https://discord.gg/3JRnDUap6y',
  'collection_items' => collection_items
}

write_json( "./pork/pork12px.json", collection )

puts "bye"
