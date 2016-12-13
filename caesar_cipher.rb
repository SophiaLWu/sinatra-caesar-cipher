require "sinatra"
require "sinatra/reloader" if development?

# Takes a string and shift factor and outputs the Caesar ciphered string
def caesar_cipher(str, shift_factor)
  letters = str.split("")
  shift_factor %= 26

  letters = letters.map do |letter|
    if letter =~ /[a-zA-Z]/
      curr_ord = letter.ord
      new_ord = curr_ord + shift_factor

      if (letter =~ /[A-Z]/ && new_ord > 90) || 
         (letter =~ /[a-z]/ && new_ord > 122)
        new_ord -= 26
      end 

      letter = new_ord.chr
    end
    letter
  end

  letters.join

end

get "/" do
  ciphertext = params["ciphertext"]
  shift_factor = params["shift"].to_i
  if ciphertext != nil && shift_factor != nil
    ciphered_text = caesar_cipher(ciphertext, shift_factor)
  end
  erb :index, :locals => {:ciphered_text => ciphered_text}
end