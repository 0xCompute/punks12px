require 'digest'
require 'datauris'
require 'ethscribe'

net = Ethscribe::Api.mainnet    


missing = []


force = false    # true


(0..83).each do |i|
    num = '%02d' % i
    path = "./pork/hashcheck/#{num}.json"

    if File.exist?( path ) && force == false
        ## skip; already checked
    else
      puts "==> #{i}..."

      blob = read_blob( "./pork/ethscribe/pork#{i}.png" )
      uri = DataUri.build( blob, "image/png" )
      hash = Digest::SHA256.hexdigest( uri )
      pp hash

      data = net.ethscription_exists( hash )
      if data['result']
        write_json( path, data ) 
      else
         puts "!! no match found"
         pp data
         missing << i   ## keep track of missing punks
      end
   end
end


puts "  #{missing.size} missing punk(s) found:"
pp missing


puts "bye"