require 'vault'
require 'date'

$stdout.sync = true
$stderr.sync = true

def check_input
  @unseal_key_array = ENV['UNSEAL_KEYS']&.split(' ') || []
  abort "Not Valid Vault Token: #{key}" if @unseal_key_array.map{|k| k.bytesize != 44}.any?
  abort 'RECHECK_TIME is not valid' unless ENV['RECHECK_TIME']&.to_i > 0
  abort 'VAULT_ADDR is not valid' unless ENV['VAULT_ADDR']&.size > 0
end

def unseal_loop

  loop do
    if Vault.sys.seal_status.sealed?
      @unseal_key_array.each do |key|
        Vault.sys.unseal(key)
      end

      puts "Vault has been unsealed on #{DateTime.now.strftime('%D %T')}"
    end
    sleep ENV['RECHECK_TIME'].to_i
  end
rescue Vault::HTTPConnectionError
  puts "VAULT at: #{ENV['VAULT_ADDR']} is UNREACHABLE on #{DateTime.now.strftime('%D %T')}"
  sleep ENV['RECHECK_TIME'].to_i

  unseal_loop
end

check_input

puts 'Starting Sentenial'
puts "Looking after VAULT at: #{ENV['VAULT_ADDR']}"
puts "Will unseal every #{ENV['RECHECK_TIME']} seconds"

unseal_loop
