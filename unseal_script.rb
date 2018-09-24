require 'vault'
require 'date'

$stdout.sync = true
$stderr.sync = true

puts 'Starting Sentenial'
puts "Looking after VAULT at: #{ENV['VAULT_ADDR']}"
puts "Will unseal every #{ENV['RECHECK_TIME']} seconds"


unseal_key_array = ENV['UNSEAL_KEYS'].split(' ')

loop do
  if Vault.sys.seal_status.sealed?
    unseal_key_array.each do |key|
      abort "Not Valid Vault: #{key}" if key.bytesize != 44

      Vault.sys.unseal(key)
    end

    puts "Vault has been unsealed on #{DateTime.now.strftime('%D %T')}"
  end
  sleep ENV['RECHECK_TIME'].to_i
end
